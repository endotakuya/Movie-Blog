'use strict'

$(document).ready(function(){

    /*
     * 画像を非同期でAWS S3にアップロード
     */
    const _selectImages = $('#select-iamges')

    $('#open-finder').click( function(){
        _selectImages.click()
        return false
    })

    _selectImages.on('change', function(){
        const form = $('#uploader').get()[0]
        const formData = new FormData(form)
         // Ajaxで送信
        $.ajax({
            url: '/uploads',
            method: 'post',
            // dataに FormDataを指定
            data: formData,
            // Ajaxがdataを整形しない指定
            processData: false,
            // contentTypeもfalseに指定
            contentType: false
            
            }).done(function( res ) {
                // Upload Success
                $('.upload_desc').show()
                clipURL()
            }).fail(function( jqXHR, textStatus, errorThrown ) {
                // Upload Error
                console.log( 'ERROR', jqXHR, textStatus, errorThrown );
            })

        return false
    })
        
    /*
     * クリップボードに画像URLをコピー 
     */
    function clipURL(){
        var clipArray = []
        $('#upload_images li').each(function(index) {
            var id = $(this).find('a').attr('id')
            clipArray.push(new ZeroClipboard($('#' + id)))
        })

        clipArray.forEach(function(clip){
            clip.on( "aftercopy", function( e ) {
                $('.upload_desc').text('クリップボードに保存しました')
                setTimeout(backMessage, 2000);
            } );
        })        
    }

    // クリップボードメッセージを修正
    var backMessage = function backMessage(){
       $('.upload_desc').text('写真を選択すると、URLがクリップボードにコピーされます')
    }

    clipURL()

})