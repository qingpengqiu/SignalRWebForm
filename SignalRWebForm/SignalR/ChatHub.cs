using System;
using System.Collections.Concurrent;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR;
using Microsoft.Owin;
namespace SignalRDemo
{
    public class MyChat : Hub
    {
        /// <summary>
        /// Sends the specified message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Send(string message)
        {
            // Call the addMessage method on all clients         
            Clients.All.addMessage(message);
        }
    }
}