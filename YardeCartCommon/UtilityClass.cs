using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Security.Cryptography;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;

namespace YardeCartCommon
{
    public class UtilityClass
    {

        private static byte[] KEY_64 = { 42, 16, 93, 156, 78, 4, 218, 32 };
        private static byte[] IV_64 = { 55, 103, 246, 79, 36, 99, 167, 3 };

        //24 byte or 192 bit key and IV for TripleDES 
        private static byte[] KEY_192 = { 42, 16, 93, 156, 78, 4, 218, 32, 15, 167, 
    44, 80, 26, 250, 155, 112, 2, 94, 11, 204, 
    119, 35, 184, 197 };
        private static byte[] IV_192 = { 55, 103, 246, 79, 36, 99, 167, 3, 42, 5, 
    62, 83, 184, 7, 209, 13, 145, 23, 200, 58, 
    173, 10, 121, 222 };

        public static string EnryptString(string strEncrypted)
        {
            byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(strEncrypted);
            string encryptedConnectionString = Convert.ToBase64String(b);
            return encryptedConnectionString;
        }

        public static string DecryptString(string encrString)
        {
            byte[] b = Convert.FromBase64String(encrString);
            string decryptedConnectionString = System.Text.ASCIIEncoding.ASCII.GetString(b);
            return decryptedConnectionString;
        }

        public static string Encrypt(string value)
        {
            string str = "";
            if (!string.IsNullOrEmpty(value))
            {
                DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, cryptoProvider.CreateEncryptor(KEY_64, IV_64), CryptoStreamMode.Write);
                StreamWriter sw = new StreamWriter(cs);

                sw.Write(value);
                sw.Flush();
                cs.FlushFinalBlock();
                ms.Flush();

                //convert back to a string 
                str = Convert.ToBase64String(ms.GetBuffer(), 0, Convert.ToInt32(ms.Length));
            }
            return str;
        }

        public static string ServerPath()
        {
            string strPath = "";

            //            strPath = Request.ServerVariables["SERVER_PROTOCOL"].ToString().ToLower().Substring(0, 4).ToString() + "://" + Request.ServerVariables["SERVER_NAME"].ToString();

            return strPath;
        }

        public static string Decrypt(string value)
        {
            string str = "";
            if (!string.IsNullOrEmpty(value))
            {
                DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();

                //convert from string to byte array 
                byte[] buffer = Convert.FromBase64String(value);
                MemoryStream ms = new MemoryStream(buffer);
                CryptoStream cs = new CryptoStream(ms, cryptoProvider.CreateDecryptor(KEY_64, IV_64), CryptoStreamMode.Read);
                StreamReader sr = new StreamReader(cs);

                str = sr.ReadToEnd();
            }
            return str;
        }

        public static void SendMail(string gmailUserName, string gmailPassword, string mailFrom, string mailTo, string commaDelimCCs, string subject, string message, bool isBodyHtml)
        {

            try
            {
                System.Net.Mail.MailAddress fromAddress = new System.Net.Mail.MailAddress(gmailUserName, "from yardecart.com");
                System.Net.Mail.MailAddress toAddress = new System.Net.Mail.MailAddress(mailTo, "User");
                System.Net.Mail.MailMessage msg = new
                System.Net.Mail.MailMessage(fromAddress, toAddress);
                msg.IsBodyHtml = isBodyHtml;
                msg.Subject = subject;
                msg.Body = message;
                if (commaDelimCCs != "")
                    msg.CC.Add(commaDelimCCs);
                System.Net.NetworkCredential cred = new System.Net.NetworkCredential(gmailUserName, gmailPassword);
                System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient("smtp.gmail.com", 25);//587 r 551
                mailClient.EnableSsl = true;
                mailClient.UseDefaultCredentials = false;
                mailClient.Credentials = cred;
                mailClient.Send(msg);
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public static bool IsValidEmail(string inputEmail)
        {
            // inputEmail = NulltoString(inputEmail);
            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail))
                return (true);
            else
                return (false);
        }

        public static void GetYouTubeURL(string url, out string imageURL, out string videoURL)
        {

            int startIndex = Convert.ToInt32(url.LastIndexOf("="));
            int endIndex = url.Trim().Length;

            string baseImageUrl = "http://img.youtube.com/vi/";
            string imageName = url.Trim().Substring(startIndex + 1, endIndex - 1 - startIndex);
            //Image1.Width = 100;
            //Image1.Height = 100;
            //string imageUrl =  TextBox1.Text.ToString().Substring(Convert.ToInt32(TextBox1.Text.ToString().LastIndexOf("=")), TextBox1.Text.ToString().Length).ToString();
            //Image1.ImageUrl = baseImageUrl + imageName + "/default.jpg";
            ////HyperLink1.NavigateUrl = HttpContext.Current.Request.Url;
            //HyperLink1.ImageUrl = baseImageUrl + imageName + "/default.jpg";
            //HyperLink1.NavigateUrl = HttpContext.Current.Request.Url.ToString();

            imageURL = baseImageUrl + imageName + "/default.jpg";

            string baseVideoUrl = "http://www.youtube.com/v/";
            baseVideoUrl += imageName;
            videoURL = baseVideoUrl;
            //videoURL = string.Format("<embed runat='server' id='VideoPlayer' "
            //+ "src='{0}' type='application/x-shockwave-flash'"
            //+ "allowscriptaccess='always' allowfullscreen='true' width='425' height='344'> </embed>", baseVideoUrl);




            //string ss = string.Format("<object width='560' height='340'><param name='movie'"
            //                           + "value='http://www.youtube.com/v/A5xRqVZgE-c&hl=en&fs=1&'>"
            //                           + "</param><param name='allowFullScreen' value='true'></param>"
            //                           + "<param name='allowscriptaccess' value='always'></param>"
            //                           + "<embed src='http://www.youtube.com/v/A5xRqVZgE-c&hl=en&fs=1&' "
            //                           + "type='application/x-shockwave-flash' allowscriptaccess='always' "
            //                           + "allowfullscreen='true' width='560' height='340'></embed></object>");

            //http://www.youtube.com/v/SQDlsbn349Y

            //string baseVideoUrl = "http://www.youtube.com/v/";
            //baseVideoUrl += imageName + "?autoplay=1";
            //string ss = string.Format("<embed runat='server' id='VideoPlayer' "
            //            + "src='{0}' type='application/x-shockwave-flash'"
            //            + "allowscriptaccess='always' allowfullscreen='true' width='425' height='344'> </embed>", baseVideoUrl);

            //divId.InnerHtml = ss;
        }

    }
}
