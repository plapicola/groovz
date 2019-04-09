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
        userSavedTrack(trackInfo.spotify_id);
    }
  });
}

function userSavedTrack(trackId) {
  const trackStatusUrl = 'api/v1/me/track_status?id=\`${trackId}\`';

  fetch(trackStatusUrl)
  .then(function(response){
    response.json();
  })
  .then(function(boolean){
    console.log(boolean)
  })
}

async function saveSong() {
  const saveUrl = "api/v1/me/save_track";

  fetch(songUrl)
    .then(function(response) {
      response.json();
    })
    .then(function(result) {
      console.log(result);

    })
}
