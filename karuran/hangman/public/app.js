'user strict';
(function() {

  var images = [
                './img/1.png', './img/2.png',
                './img/3.png', './img/4.png',
                './img/5.png', './img/6.png',
                './img/6.png', './img/7.png'
               ];

  var correctAnswer;
  var userAnswer;
  var i;
  var missCount = 0;

  var preImages = [];
  for (i=0; i<images.length; i++){
    preImages[i] = new Image();
    preImages[i].src = images[i];
  }

  $.getJSON('/api', function(word) {
    console.log(word);
    correctAnswer = word.split('');
    generateUserAnswer();
  });

  var generateUserAnswer = function() {
    userAnswer = new Array(correctAnswer.length);
    for(i=0; i<userAnswer.length; i++) {
      userAnswer[i] = '_';
    }
    showAnswer();
  };


  var btn = $('button');
  btn.bind('click', function() {
    $(this).attr('disabled', true);
    answerCheck(this.innerHTML);
  });

  var answerCheck = function(ans) {
    i = 0;
    missFlag = true;
    jQuery.each(correctAnswer, function() {
      if (this == ans) {
        userAnswer[i] =  ans;
        missFlag = false;
      }

      i++;
    });

    if (missFlag === true) {
      missCount++;
      changeImage();
    }

    showAnswer();
  };

  var changeImage = function() {
    $('#hangman').attr('src', './img/' + missCount + '.png');

    if (missCount == 7) {
      gameOver();
    }
  };

  var showAnswer = function() {
    var answerStr = userAnswer.join('');
    var userAnsElm = document.getElementById('userAns');
    userAnsElm.innerHTML = answerStr;

    if (jQuery.inArray('_', userAnswer) == -1) {
      gameClear();
    }
  };

  var gameOver = function() {
    btn.attr('disabled', true);
    $('h1').addClass('gameover');
  };

  var gameClear = function() {
    $('h1').addClass('gameclear');
    $('h1').text('Safe...');
  };
})();
