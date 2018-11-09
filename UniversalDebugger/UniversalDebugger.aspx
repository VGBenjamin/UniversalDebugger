<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UniversalDebugger.aspx.cs" Inherits="Dlw.ScBase.Website.UniversalDebugger" ValidateRequest="False" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <style type="text/css" media="screen">
        body {
            background-color: #272822;
            color: #FFF;
        }

        input, textarea {
            background-color: #272822;
            color: #CFD0D2;
        }

        .bg-dark {
            background-color: #2F3129 !important;
        }

        .logo {
            background-image: url('data:image/png;base64,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');
            background-repeat: no-repeat;
            position: absolute;
            width: 83px;
            height: 48px;
            top: -8px;
            left: 0px;
        }

        .executionTime {
            font-size: small;
            text-align: right;
        }

        .labeled {
            border: solid 1px #CFD0D2;
        }

        .labeled .label {
            background-color: #CFD0D2;
        }

        .labeled textarea {
            border: none;
        }

        .run {
            background-image:  url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAQAAABKfvVzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAKqNIzIAAAAJcEhZcwAADdcAAA3XAUIom3gAAAAHdElNRQfiAhYIFyXYfkpjAAABEklEQVQ4y5WUrUvDURSGnzvGwDJhlgWjgjDDYFWbTotO46xGP5pYzcM2rP4PwyLDaBPBsGnYQEHDDBto8/OxGCaKv7sT7z0v73POvecAVr2xSnx44Id6bikmOwXAPfOMceGx+TiHOzDlpj2f3TcTJQAwa80Xu65FCgCcsqGeOftfDUMRuqFCmTxXHjkR4fB9lnbbvgN3TUcJAMxZ981rl/5FGoIbhB2KPHDqidMRAoDQDmUqzND20PEEpCG4jHs++Wgp0SG6Sz/uV+34GolkwaZGFm3OOldMshxWQicBacSHc9GW739/jV9ITtmgSY9i2Ar9BIFZa7QpsB4WQiuhrSMOkHNe+hk/oiMsAcANb+PXzBdtGsd59ATIuwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxOC0wMi0yMlQwODoyMzozNyswMTowMP7eRT0AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTgtMDItMjJUMDg6MjM6MzcrMDE6MDCPg/2BAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAABJRU5ErkJggg==');
            padding-left: 34px !important;
            background-repeat: no-repeat;
            background-position-y: 10px;
            background-position-x: 5px;
            font-weight: bold;
        }

        .logo-col {
            padding-left: 73px;
            font-weight: bold;
            font-size: 22px;
        }

        .nav-item:hover {
            border-bottom: red solid 1px;
        }

        .row.next {
            margin-top: 20px;
        }

        .codeeditor {
            padding: 0;
            height: 600px;
        }

        #editor {
            width: 100%;
            height: 100%;
        }

    </style>
</head>
<body style="height: 100%">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
            <div class="col-md-2 logo-col">
                <div class="logo">&nbsp;</div>Universal debugger               
            </div>
            
            <div class="col-md-10">           
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <asp:LinkButton ID="Go" runat="server" OnClick="Go_Click" Text="Run Now" CausesValidation="False" CssClass="nav-link run" />
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 sidebar">
                    <b>System dlls to load</b><br/>
                    <asp:TextBox ID="SystemDllsToLoad" runat="server" TextMode="MultiLine" Width="100%" Height="200"/>
                    <b>Project dlls to load</b><br/> <small>(default: the dlls of your bin folder)</small>
                    <asp:TextBox ID="ProjectDllsToLoad" runat="server" TextMode="MultiLine" Width="100%" Height="500"/>
                </div>
                <div class="col-md-10 col-md-offset-2 main">
                    <div class="row" >
                        <div class="col-md-12 labeled">
                            <div class="row label">
                                <div class="col-1">Code</div>
                            
                            </div>
                            <div class="row">
                                <div class="col-12 placeholder codeeditor">
                                    <pre id="editor"></pre>                                    
                                    <textarea rows="2" cols="20" id="code" style="height:400px;width:100%;" name="code"><asp:Literal runat="server" ID="CodeLiteral"/></textarea>
                                </div>   
                            </div>
                        </div>                                         
                    </div>
                    
                    <div class="row next" >
                        <div class="col-md-12 labeled">
                            <div class="row label">
                                <div class="col-md-1">Output</div>
                                <div class="offset-md-9 col-md-2 executionTime">Executed in <asp:Literal ID="TimeExecution" runat="server"  />ms</div>                            
                            </div>
                            <div class="row">
                                <div class="col-12 placeholder">
                                    <asp:TextBox ID="Output" runat="server" TextMode="MultiLine" Width="100%" Height="200"  Enabled="False" />
                                </div>   
                            </div>
                        </div>                                         
                    </div>
                </div>
            </div>
        </div>

    </form>

    
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.3.1/ace.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.3.1/mode-csharp.js" type="text/javascript" charset="utf-8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.3.1/theme-monokai.js" type="text/javascript" charset="utf-8"></script>
    
    <script type="text/javascript" src="https://www.strictly-software.com/scripts/downloads/encoder.js"></script>

    <script>
        function updateEncoded() {
            var encoded = Encoder.htmlEncode(editor.getSession().getValue(), true);
            textarea.val(encoded);
        }

        var editor = ace.edit("editor");
        editor.setTheme("ace/theme/monokai");
        editor.session.setMode("ace/mode/csharp");

        var textarea = $('textarea[name="code"]').hide();
        editor.getSession().setValue(textarea.val());
        editor.getSession().on('change', function () {
            updateEncoded();
        });

        updateEncoded();
    </script>
</body>
</html>
