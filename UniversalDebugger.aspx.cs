using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.CodeDom.Compiler;
using System.Collections;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using Microsoft.CSharp;
using System.Reflection;
using System.Globalization;
using System.Drawing;
using System.Security;
using System.Text;

[assembly: TagPrefix("ud", "UnvalidatedTextBox")]
public class UnvalidatedTextBox : System.Web.UI.WebControls.TextBox
{
    protected override bool LoadPostData(string postDataKey, NameValueCollection postCollection)
    {
        return false;
    }
}

namespace Dlw.ScBase.Website
{    

    public partial class UniversalDebugger : System.Web.UI.Page
    {
        /// <summary>
        /// You should consider to change this guid before putting the debgger on an live environement!
        /// </summary>
        private readonly string _securityGuid = "D88D39A8-438E-44A0-B174-EF5FD2FC030";


        public string CodeValue { get; set; }

        //The following dlls will be not added by default
        private readonly List<string> _doNotIncludeDllPerDefault = new List<string>()
        {
            "System.Web.Mvc.dll",
            "Microsoft.ApplicationInsights.Extensions.Intercept_x64.dll",
            "Microsoft.ApplicationInsights.Extensions.Intercept_x86.dll",
        };


        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Request.QueryString["security"].Equals(_securityGuid, StringComparison.InvariantCultureIgnoreCase))
                throw new SecurityException("The security token is not correct!");

            if (!IsPostBack)
            {
                this.SystemDllsToLoad.Text = @"System.dll
mscorlib.dll
System.Core.dll
System.Runtime.dll";

                this.ProjectDllsToLoad.Text = GetAllDllsFromBinFolder();

                this.CodeLiteral.Text = @"using System;
using System.Collections.Generic;

namespace Test
{
    class Program
    {
        public static IEnumerable<string> Main()
        {
            //Your code here
            

                yield return ""coucou"";
        }
    }
}";
            }
        }

        private string GetAllDllsFromBinFolder()
        {
            StringBuilder sb = new StringBuilder();

            var path = Server.MapPath("~/bin");
            foreach (var filePath in Directory.GetFiles(path))
            {
                var fileName = filePath.Remove(0, path.Length + 1);
                if (filePath.EndsWith(".dll") && !_doNotIncludeDllPerDefault.Contains(fileName))
                    sb.AppendLine(filePath.Remove(0, path.Length+1));
            }
            return sb.ToString();
        }

        protected void Go_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.Output.Text = string.Empty;
				
                var code = HttpUtility.HtmlDecode(Request.Unvalidated.Form["code"]); // Validation bypassed
                this.CodeLiteral.Text = code;

                Tuple<string, IEnumerable<object>> tuple = CompileAndRun(code);

                StringBuilder sb = new StringBuilder();
                foreach (var item in tuple.Item2)
                {
                    sb.AppendLine(item.ToString());
                }
                this.Output.Text = sb.ToString();
                this.TimeExecution.Text = tuple.Item1;
            }
            catch (Exception ex)
            {
                this.Output.ForeColor = Color.Red;
                this.Output.Text = ex.Message;
            }
        }

        public Tuple<string, IEnumerable<object>> CompileAndRun(string code)
        {
            CompilerParameters compilerParameters = new CompilerParameters
            {
                GenerateInMemory = true,
                TreatWarningsAsErrors = false,
                GenerateExecutable = false,
                CompilerOptions = "/optimize"            
            };

            var system = FromDllBox(this.SystemDllsToLoad);

            var directory = Path.GetDirectoryName(HttpContext.Current.Request.PhysicalApplicationPath + "bin\\");
            var bin = FromDllBox(this.ProjectDllsToLoad).Select(f => string.Format("{0}\\{1}", directory, f)).ToList();

            foreach (var systemDll in system)
            {
                if(!bin.Any(x => x.EndsWith(systemDll, StringComparison.InvariantCultureIgnoreCase)))
                    bin.Add(systemDll);
            }

            compilerParameters.ReferencedAssemblies.AddRange(bin.ToArray());
            //compilerParameters.ReferencedAssemblies.AddRange(bin);

 
            CSharpCodeProvider cSharpCodeProvider = new CSharpCodeProvider();
            CompilerResults compilerResults = cSharpCodeProvider.CompileAssemblyFromSource(compilerParameters, new string[]
            {
                code
            });
            if (compilerResults.Errors.HasErrors)
            {
                string text = "Compile error: ";
                foreach (CompilerError compilerError in compilerResults.Errors)
                {
                    text = text + Environment.NewLine + compilerError.ToString();
                }
                return new Tuple<string, IEnumerable<object>>("0", new List<object>() { text });
            }
            UniversalDebugger.ExploreAssembly(compilerResults.CompiledAssembly);
            Module module = compilerResults.CompiledAssembly.GetModules()[0];
            Type type = null;
            MethodInfo methodInfo = null;
            if (module != null)
            {
                type = module.GetType("Test.Program");
            }
            if (type != null)
            {
                methodInfo = type.GetMethod("Main");
            }
            if (methodInfo != null)
            {
                Stopwatch stopwatch = new Stopwatch();
                stopwatch.Start();
                IEnumerable<object> item = methodInfo.Invoke(null, new object[]
                {                    
                }) as IEnumerable<object>;
                stopwatch.Stop();
                return new Tuple<string, IEnumerable<object>>(stopwatch.ElapsedMilliseconds.ToString(CultureInfo.InvariantCulture), item);
            }
            return new Tuple<string, IEnumerable<object>>("0", new List<object>());
        }

        private string[] FromDllBox(TextBox dllsToLoad)
        {
            return dllsToLoad.Text.Split(new Char[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
        }

        private static void ExploreAssembly(Assembly assembly)
        {
            Console.WriteLine("Modules in the assembly:");
            Module[] modules = assembly.GetModules();
            for (int i = 0; i < modules.Length; i++)
            {
                Module module = modules[i];
                Console.WriteLine("{0}", module);
                Type[] types = module.GetTypes();
                for (int j = 0; j < types.Length; j++)
                {
                    Type type = types[j];
                    Console.WriteLine("t{0}", type.Name);
                    MethodInfo[] methods = type.GetMethods();
                    for (int k = 0; k < methods.Length; k++)
                    {
                        MethodInfo methodInfo = methods[k];
                        Console.WriteLine("tt{0}", methodInfo.Name);
                    }
                }
            }
        }
    }
}
