using System;
using System.IO;
using System.Net;

namespace Server
{
    class Program
    {
        static void Main(string[] args)
        {
            String port = "5050";
            //String url = "http://10.0.0.1:";
            //String url = "http://*:5050/";
            
            //String url = "http://*:";
            String url = "http://localhost:";

            if (args.Length >= 1)
            {
                port = args[0];
            }
            url = url + port + "/";
            HttpListener listener = new HttpListener();
            listener.Prefixes.Add(url);
            
            // MUST RUN as Administrator (so run Visual Studio as Administrator)
            listener.Start();
            Console.WriteLine("Listening (" + url + ")...");

            while (true)
            {
                HttpListenerContext context = listener.GetContext();
                HttpListenerRequest request = context.Request;
                HttpListenerResponse response = context.Response;

                String sPhysicalFilePath = Directory.GetCurrentDirectory() + request.RawUrl;
                //String sPhysicalFilePath = @"C:\Sanath\AppData\Dropbox\Public\Projects\ProcessingJS\" + request.RawUrl;

                if (File.Exists(sPhysicalFilePath))
                {
                    FileStream fs = new FileStream(sPhysicalFilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                    BinaryReader reader = new BinaryReader(fs);
                    //byte[] bytes = new byte[fs.Length];
                    byte[] bytes = new byte[64 * 1024];
                    int read;
                    response.ContentLength64 = fs.Length;
                    //response.SendChunked = false;
                    //response.ContentType = System.Net.Mime.MediaTypeNames.Application.Octet;
                    while ((read = reader.Read(bytes, 0, bytes.Length)) != 0)
                    {
                        response.OutputStream.Write(bytes, 0, read);
                    }
                    reader.Close();
                    fs.Close();
                }

                response.StatusCode = (int)HttpStatusCode.OK;
                response.StatusDescription = "OK";
                response.OutputStream.Close();
            }
        }
    }
}
