function Tweet() {
}

Tweet.prototype.showResponse = function(){
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
}

Tweet.prototype.showLink = function(){
  $(submit).on('click', function(){
    $('.linkToTweet').css('display', 'none')
    $('.linkToTweet').delay(4000).fadeIn(1000)
  })
}

$(function(){
  esmePage = new Tweet()
  esmePage.showResponse()
  esmePage.showLink()
})


