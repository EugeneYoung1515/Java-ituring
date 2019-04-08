<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div style="text-align:center">
    <img id="avatar" src="/LargeAvatar/${userSession.largeAvatar}" />
</div>
<div style="width:120px;margin: 10px auto">
    <input id="upload-avatar" name="upload-avatar" type="file" />
</div>

<script>
    $(document).ready(function () {
        $("#upload-avatar").kendoUpload({
            multiple: false,
            showFileList: false,
            async: {
                saveUrl: "/upload",
                autoUpload: true
            },
            success: function (e) {
                $.post("/user/setavatar", { key: e.response.key }, function (data) {
                    $("#set-avatar").html(data);
                });
            },
            upload: function (e) {
                var files = e.files;

                // Check the extension of each file and abort the upload if it is not .jpg
                $.each(files, function () {
                    if (this.extension.toLowerCase() != ".jpg" &&
                        this.extension.toLowerCase() != ".jpeg" &&
                        this.extension.toLowerCase() != ".gif" &&
                        this.extension.toLowerCase() != ".png") {
                        alert("只能上传图片文件")
                        e.preventDefault();
                    }
                });
            }

        });
    });
</script>