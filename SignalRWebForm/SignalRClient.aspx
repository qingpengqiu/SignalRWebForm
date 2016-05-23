<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignalRClient.aspx.cs" Inherits="SignalRClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="/Scripts/jquery-1.6.4.js"></script>
    <script src="/Scripts/jquery.signalR-1.2.2.js"></script>
    <script src="/signalr/hubs"></script>
    <title>SignalR Demo</title>
</head>
<body>
    <script>


        var chat;
        $(function () {
            // Created proxy,此处要特别注意，Hub类的首字母是大写MyChat，但前端使用时，首字母要小写   
            chat = $.connection.myChat;
            // Assign a function to be called by the server        
            chat.client.addMessage = onAddMessage;  
            // Register a function with the button click               
            $("#broadcast").click(onBroadcast);
            // Start the connection        
            $.connection.hub.start().done(function (a) {
                console.log("成功");
                console.log(a);
            });
        });
        function onAddMessage(message) {
            // Add the message to the list    
            $('#messages').append('<li>' + message + '</li>');
        };
        function onBroadcast() {        
            chat.server.send($('#message').val());
        }
    </script>
    <form id="form1" runat="server">
    <div>
        <input type="text" id="message" />
        <input type="button" id="broadcast" value="broadcast" />
        <ul id="messages"></ul>
    </div>
    </form>
</body>
</html>
