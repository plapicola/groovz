document.addEventListener('DOMContentLoaded', function() {
  subcribeToChannel();
}, false);

function subcribeToChannel() {
  App.messages = App.cable.subscriptions.create( {
    channel: 'PartiesChannel', room: `parties-${roomCode}`},
    {
      received: function(data) {
        let trackInfo = data.message.data.attributes;
        document.getElementById("album-art").src = trackInfo.img_url;
        document.getElementById("track-title").innerHTML = trackInfo.title;
        document.getElementById("track-artist").innerHTML = trackInfo.artist;
    }
  });
}
