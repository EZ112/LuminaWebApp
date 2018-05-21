$(function(){
  var $refreshButton = $('#refresh');
  var $results = $('#css_result');
  
  function refresh(){
    var css = $('style.cp-pen-styles').text();
    $results.html(css);
  }

  refresh();
  $refreshButton.click(refresh);
  
  // Select all the contents when clicked
  $results.click(function(){
    $(this).select();
  });       
});

  videojs('pv', {
    controls: true,
    plugins: {
      videoJsResolutionSwitcher: {
        default: 'high', // Default resolution [{Number}, 'low', 'high'],
        dynamicLabel: true
      }
    }
  }, function(){
    var player = this;
    window.player = player
    player.updateSrc([
      {
        src: './assets/video/pv/TVアニメ「ゆるキャン△」予告編映像 360.mp4',
        type: 'video/mp4',
        label: 'SD',
        res: 360
      },
      {
        src: './assets/video/pv/TVアニメ「ゆるキャン△」予告編映像 720.mp4',
        type: 'video/mp4',
        label: 'HD',
        res: 720
      }
    ])
    player.on('resolutionchange', function(){
      console.info('Source changed to %s', player.src())
    })
  })