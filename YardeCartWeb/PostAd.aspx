<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Yarde.Master" CodeBehind="PostAd.aspx.cs" Inherits="YardeCartV2.PostAd" Title="Yard e-Cart PostAd" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    
    <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
    <script type="text/javascript" src="easyUI/jquery.min.js"></script>
    <script type="text/javascript" src="easyUI/jquery.easyui.min.js"></script>

    <script src="js/ajaxupload.js" type="text/javascript"></script>
   <style type="text/css">
        input[type="button"].UploadButton
        {
            background: none;
            border: none;
            filter: none;
            background-image: url('image/Upload.png') !important;
            cursor: pointer !important;
            display: inline-block;
            width: 80px;
            height: 23px;
        }
        input[type="button"].hover
        {
            -moz-box-shadow: 0 0 3px #999;
            -webkit-box-shadow: 0 0 3px #999;
            box-shadow: 0 0 3px #999;
        }
        .UploadDiv
        {
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            background-color: #f6f6f6;
            border: 1px solid #ccc;
            border-radius: 3px;
            color: #16387C;
            display: block;
            margin: 50px auto;
            padding: 13px;
            width:500px;
            display:block;
            
        }
        .delete {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        #UploadedFile div {
            border: 1px solid #ccc;
            display: inline-block;
        }
       
    </style>
    <script type="text/javascript">

        var intStateId;
        var intCityId;
        var intCountryId;
        var strZipcode;
        var UserId;
        var adpostid;
        var strimagePath;
        
        function ServiceSucceeded(result) {
            if (DataType == "json") {
                if (method == "SelectAllCategory") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);
                    for (var i = 0; i < obj.length; i++) {
                        $("<option value=" + obj[i].CategoryId + ">" + obj[i].CategoryName + "</option>").appendTo("#ddlCategory");
                    }

                }
                else if (method == "SelectUserProfile") {
                    resultObject = result;
                    var obj = jQuery.parseJSON(result);

                    intStateId = obj[0].StateId;
                    intCityId = obj[0].CityId;
                    intCountryId = obj[0].CountryId;
                    strZipcode = obj[0].ZipCode;

                }
                else if (method == "AddAdPost") {
                    adpostid = result;
                    //alert(adpostid);
                    //UploadFiles();

                    AddPostAdImage(adpostid);
                }
            }
        }
        function SelectAllCategory() {
            Type = "GET";
            Url = sServicePath + "/SelectAllCategory";
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            method = "SelectAllCategory";
            CallService();
        }
        function AddPostAd() {
            var tilldate = $("#txtShowDate").datebox('getValue');
            var msg2 = {
                "AdPostId": "0",
                "AdPostTitle": $("#txtTitle").val(),
                "Description": $("#txtDesc").val(),
                "Keywords": $("#txtKeywords").val(),
                "UserId": UserId,
                "CategoryId": $("#ddlCategory").val(),
                "Price": $("#txtPrice").val(),
                "StateId": intStateId,
                "CityId": intCityId,
                "ZipCode": strZipcode,
                "CountryId": intCountryId,
                "AdTillDate": tilldate,
                "AdStatus": "NEW",
                "PaidStatus": "0"
            };
            var objectAsJson = JSON.stringify(msg2);

            Type = "POST";
            Url = sServicePath + "/AddAdPost";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "AddAdPost";
            CallService();
            alert("Ad posted successfully");
            window.location = "ViewPostAd.aspx?aid=" + adpostid + "&uid=" + UserId;

        }
        function AddPostAdImage(aid) {
            //debugger;
            var msg2 = {
                "ImageId": "0",
                "AdPostId": aid,
                "ImagePath": $("#strImgPath").val(),
                "VideoLink": $("#txtVideolink").val()
            };
            var objectAsJson = JSON.stringify(msg2);

            Type = "POST";
            Url = sServicePath + "/AddAdImageDetails";
            ContentType = "application/json;charset=utf-8";
            Data = objectAsJson;
            DataType = "json"; ProcessData = false;
            method = "AddAdImageDetails";
            CallService();

        }
        function SelectUserProfile() {
            var msg2 = { "UserId": UserId };
            var objectAsJson = JSON.stringify(msg2);
            method = "SelectUserProfile";
            Type = "GET";
            Url = sServicePath + "/SelectProfile/" + UserId;
            //Data = objectAsJson;
            ContentType = "application/json;charset=utf-8";
            DataType = "json"; ProcessData = false;
            CallService();
        }
        function UploadFiles() {
            //debugger;
            var t = $("#strImgPath").val();
            alert($("#strImgPath").val());
            var fileInput = $("#UploadedFile1");

            //var fileInput = $("#FileUpload1");
            //var fileData = fileInput.prop("files")[0];   // Getting the properties of file from file field
            //var formData = new window.FormData();                  // Creating object of FormData class
            //formData.append("file", fileData); // Appending parameter named file with properties of file_field to form_data
            //$.ajax({
            //    url: 'UploadFile.ashx',
            //    data: formData,
            //    processData: false,
            //    contentType:false,
            //    type: 'POST',
            //    success: function (data) {
            //        debugger;
            //        alert(data);
            //        imagePath = data;

            //        /*if (obj.StatusCode == "OK") {
            //            $('#= imagePath.ClientID %>').val(obj.ImageUploadPath);
            //            $('.result-message').html(obj.Message).show();
            //        } else if (obj.StatusCode == "ERROR") {
            //            $('.result-message').html(obj.Message).show();
            //        }*/
            //    },
            //    error: function (errorData) {
            //        debugger;
            //        alert("ERR ON  " + errorData);
            //        $('.result-message').html("there was a problem uploading the file.").show();
            //    }
            //});
        }

        $(document).ready(
        function () {
            //$.ajax({
            //    url: 'Handlers/GetSession.ashx',
            //    processData: false,
            //    contentType: false,
            //    type: 'GET',
            //    async: false,
            //    success: function (data) {
            //        var temp = data.split('/');
            //        UserId = temp[1];
            //        if (UserId == "")
            //            window.location = "Login.aspx";
            //    },
            //    error: function (errorData) {
            //        alert("ERR ON  " + errorData);
            //        $('.result-message').html("there was a problem uploading the file.").show();
            //    }
            //});

            SelectAllCategory();
            SelectUserProfile();

        });

        $(function () {

            new AjaxUpload('#UploadButton1', {
                action: 'Handlers/UploadFile.ashx',
                onComplete: function (file, response) {
                    //debugger;
                    if ($("#strImgPath").val() == "")
                        $("#strImgPath").val("/Data/TS_" + UserId + "/Images/" + response);
                    else {
                        var temp = $("#strImgPath").val();
                        $("#strImgPath").val(temp + ":" + "/Data/TS_" + UserId + "/Images/" + response);
                    }
                    $("<div><img src='image/btndelete.png' onclick=\"DeleteFile('" + response + "/1" + "')\"  class='delete'/>" + response + "</div>").appendTo('#UploadedFile1');
                    //$('#UploadStatus').html("file has been uploaded sucessfully");
                    $("#UploadButton1").hide();
                },
                onSubmit: function (file, ext) {
                    if (!(ext && /^(png|jpg)$/i.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }
                    //$('#UploadStatus').html("Uploading...");
                }
            });
            new AjaxUpload('#UploadButton2', {
                action: 'Handlers/UploadFile.ashx',
                onComplete: function (file, response) {
                    if ($("#strImgPath").val() == "")
                        $("#strImgPath").val("/Data/TS_" + UserId + "/Images/" + response);
                    else {
                        var temp = $("#strImgPath").val();
                        $("#strImgPath").val(temp + ":" + "/Data/TS_" + UserId + "/Images/" + response);
                    }
                    $("<div><img src='image/btndelete.png' onclick=\"DeleteFile('" + response + "/2" + "')\"  class='delete'/>" + response + "</div>").appendTo('#UploadedFile2');
                    //$('#UploadStatus').html("file has been uploaded sucessfully");
                    $("#UploadButton2").hide();
                },
                onSubmit: function (file, ext) {
                    if (!(ext && /^(png|jpg)$/i.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }
                    //$('#UploadStatus').html("Uploading...");
                }
            });
            new AjaxUpload('#UploadButton3', {
                action: 'Handlers/UploadFile.ashx',
                onComplete: function (file, response) {
                    if ($("#strImgPath").val() == "")
                        $("#strImgPath").val("/Data/TS_" + UserId + "/Images/" + response);
                    else {
                        var temp = $("#strImgPath").val();
                        $("#strImgPath").val(temp + ":" + "/Data/TS_" + UserId + "/Images/" + response);
                    }
                    $("<div><img src='image/btndelete.png' onclick=\"DeleteFile('" + response + "/3" + "')\"  class='delete'/>" + response + "</div>").appendTo('#UploadedFile3');
                    //$('#UploadStatus').html("file has been uploaded sucessfully");
                    $("#UploadButton3").hide();
                },
                onSubmit: function (file, ext) {
                    if (!(ext && /^(png|jpg)$/i.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }
                    //$('#UploadStatus').html("Uploading...");
                }
            });
            new AjaxUpload('#UploadButton4', {
                action: 'Handlers/UploadFile.ashx',
                onComplete: function (file, response) {
                    if ($("#strImgPath").val() == "")
                        $("#strImgPath").val("/Data/TS_" + UserId + "/Images/" + response);
                    else {
                        var temp = $("#strImgPath").val();
                        $("#strImgPath").val(temp + ":" + "/Data/TS_" + UserId + "/Images/" + response);
                    }
                    $("<div><img src='image/btndelete.png' onclick=\"DeleteFile('" + response + "/4" + "')\"  class='delete'/>" + response + "</div>").appendTo('#UploadedFile4');
                    //$('#UploadStatus').html("file has been uploaded sucessfully");
                    $("#UploadButton4").hide();
                },
                onSubmit: function (file, ext) {
                    if (!(ext && /^(png|jpg)$/i.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }
                    //$('#UploadStatus').html("Uploading...");
                }
            });
            new AjaxUpload('#UploadButton5', {
                action: 'Handlers/UploadFile.ashx',
                onComplete: function (file, response) {
                    if ($("#strImgPath").val() == "")
                        $("#strImgPath").val("/Data/TS_" + UserId + "/Images/" + response);
                    else {
                        var temp = $("#strImgPath").val();
                        $("#strImgPath").val(temp + ":" + "/Data/TS_" + UserId + "/Images/" + response);
                    }
                    $("<div><img src='image/btndelete.png' onclick=\"DeleteFile('" + response + "/5" + "')\"  class='delete'/>" + response + "</div>").appendTo('#UploadedFile5');
                    //$('#UploadStatus').html("file has been uploaded sucessfully");
                    $("#UploadButton5").hide();
                },
                onSubmit: function (file, ext) {
                    if (!(ext && /^(png|jpg)$/i.test(ext))) {
                        alert('Invalid File Format.');
                        return false;
                    }
                    //$('#UploadStatus').html("Uploading...");
                }
            });

        });
        function DeleteFile(file) {
            //$('#UploadStatus').html("deleting...");
            debugger;
            var file1 = file.split('/');
            $.ajax({
                url: "Handlers/UploadFile.ashx?file=" + file1[0],
                type: "GET",
                cache: false,
                async: true,
                success: function (html) {
                    debugger;
                    var temp = $("#strImgPath").val();
                    if (file1[1] == "1")
                        temp = temp.replace("/Data/TS_" + UserId + "/Images/" + file1[0], "");
                    else
                        temp = temp.replace(":/Data/TS_" + UserId + "/Images/" + file1[0], "");

                    alert(temp);
                    $("#strImgPath").val(temp);
                    $("#UploadedFile" + file1[1]).html("");
                    //$('#UploadStatus').html("file has been deleted");
                    $("#UploadButton" + file1[1]).show();

                }
            });

        }

    </script>
<div id="form-content" style="vertical-align: central; padding-left: 100px; padding-top: 50px;">
        <table style="width: 789px">
            <tr>
                <td colspan="2" class="auto-style21">
                    <div class="divHeadForm" style="text-align: left;">
                        <h3>Post An Ad in 30 Secs</h3>
                        <p>&nbsp;</p>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width:250px; height:35px;">
                    <label>Title</label>
                </td>
                <td>
                    <input type="text" id="txtTitle" style="width: 200px;"  class="easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td style="width:250px; height:70px;">
                    <label>Description</label>
                </td>
                <td>
                    <textarea id="txtDesc" style="width:300px; height:50px;" maxlength="1000"></textarea>
                </td>
            </tr>

            <tr>
                <td style="width:250px; height:70px;">
                    <label>Keywords</label></td>
                <td>
                    <textarea id="txtKeywords" style="width:300px; height:50px;" maxlength="1000"  class="easyui-validatebox" data-options="required:true"></textarea>
                </td>
            </tr>

            <tr>
                <td style="width:250px; height:35px;">
                    <label>Category</label></td>
                <td>
                    <select id="ddlCategory" style="width: 200px;"></select>
                </td>
            </tr>

            <tr>
                <td style="width:250px; height:35px;">
                    <label>Price</label></td>
                <td>
                    <input type="text" id="txtPrice" style="width: 200px;"  class="easyui-validatebox" data-options="required:true"/>
                </td>
            </tr>

            <tr>
                <td style="width:250px; height:35px;">
                    <label>Show Till Date</label></td>
                <td>
                    <input id="txtShowDate" type="text" class="easyui-datebox" data-options="required:true" />
                </td>
            </tr>
            <tr>
                <td style="width:250px; height:35px;">
                    <label>Add Image for Ad</label>
                </td>
                <td>
                    <div class="UploadDiv">
                        <input type="button" id="UploadButton1" class="UploadButton"  /><br /><div id="UploadedFile1"> </div>  
                        <input type="button" id="UploadButton2" class="UploadButton"  /><br /><div id="UploadedFile2"> </div>
                        <input type="button" id="UploadButton3" class="UploadButton"  /><br /><div id="UploadedFile3"> </div>
                        <input type="button" id="UploadButton4" class="UploadButton"  /><br /><div id="UploadedFile4"> </div>
                        <input type="button" id="UploadButton5" class="UploadButton"  /><br /><div id="UploadedFile5"> </div>
                    <div id="UploadedFile">
                    </div>  
                    </div>  
                </td>
            </tr>
            
            <tr>
                <td style="width:250px; height:35px;">
                    <label>Youtube Video link</label></td>
                <td>
                    <input type="text" id="txtVideolink" style="width: 200px;"/>
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <br />
                    <br />
                    <br />
                    <input id="btnAddPost" type="button" class="YardButton" value="Add Post" onclick="AddPostAd();" />
                </td>
            </tr>

        </table>
        <input type="hidden" id="strImgPath" />
    </div>
</asp:Content>