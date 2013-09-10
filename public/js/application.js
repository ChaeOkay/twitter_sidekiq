$(function(){
  console.log('in the function')
    $('#tweetas').submit(function(e){
      e.preventDefault();
      var $formUrl = '/' + $('#user_id').val() + '/tweet'

      $.ajax({
        url: $formUrl,
        type: 'post',
        data: $(this).serialize()
      }).done(function(response){
        console.log(response);
        $('#confirmation').prepend(response);

      }).fail(function(jqXHR, textStat, errorMsg){
        console.log(jqXHR + " " + errorMsg);
      });
    })
})


