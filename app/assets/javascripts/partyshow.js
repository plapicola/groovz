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
  const trackStatusUrl = `api/v1/me/track_status?id=${trackId}`;
  fetch(trackStatusUrl)
  .then(function(response){
    return response.json();
  })
  .then(function(trackStatus){
    let track = trackStatus.data.attributes;
    renderSaveButton(track.id, track.status);
  })
}

async function renderSaveButton(trackId, type){
  if (type === false) {
    target = getElementById("save-track");
    target.src = "placeholder-pluss.png";
    target.setAttribute('onclick', saveOrRemoveTrack(trackId, true));
  }
  else {
  target = getElementById("save-track");
  target.src = "placeholder-checkmark.png";
  target.setAttribute('onclick', saveOrRemoveTrack(trackId, false));
  }
}

async function saveOrRemoveTrack(trackId, type) {
  const saveUrl = `api/v1/me/save_track?ids=${trackId}&type=${type}`;
  if (type === true) {
  renderSaveButton(trackId, false)
  }
  else {
    renderSaveButton(trackId, true)
  };
  fetch(songUrl)
    .then(function(response) {
        response.json();
    })
    .then(function(message){
      console.log(message);
    })
}
