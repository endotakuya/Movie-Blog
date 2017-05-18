'use strict'

$(document).ready(function(){

  /*
  * 記事編集ページだと Simple Markdown Editor が適応されないので
  * 100ms遅延させる
  */
  setTimeout(function(){
    const simplemde = new SimpleMDE({
      element: $("#simple-editor")[0],
      forceSync: true
    });
  },100);

});
