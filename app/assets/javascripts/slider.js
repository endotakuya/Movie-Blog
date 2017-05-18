$(function() {

  for(i = 1; i < 6; i++){
    sliderBar(i)
  }

  function sliderBar(i){
    defalut_val = $('input[type=hidden].s-val-' + i).val();
    if (!defalut_val){
      defalut_val = 0;
      $('input[type=hidden].s-val-' + i).val(0);
    }

    $('#slider-' + i + '-val').text(defalut_val)
    $( "#slider-0" + i ).slider({
        max: 5,
        min: 0,
        value: defalut_val,
        step: 1 ,
        change: function( event, ui ) {
          $('#slider-' + i + '-val').text(ui.value)
          $('input[type=hidden].s-val-' + i).val(ui.value)
        }
    });
  }

});
