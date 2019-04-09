document.addEventListener('DOMContentLoaded', function() {
  subcribeToChannel();
}, false);

function subcribeToChannel() {
  App.messages = App.cable.subscriptions.create( {
    channel: 'PartiesChannel', room: `parties-${roomCode}`},
    {
      received: function(data) {
        updateTrackInfo(data);
        userSavedTrack(data);
    }
  });
}

function updateTrackInfo(data){
  let trackInfo = data.message.data.attributes;
  document.getElementById("album-art").src = trackInfo.img_url;
  document.getElementById("track-title").innerHTML = trackInfo.title;
  document.getElementById("track-artist").innerHTML = trackInfo.artist;
}

function userSavedTrack(data) {
  let trackId = data.message.data.attributes.spotify_id
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

function renderSaveButton(trackId, type){
  target = document.getElementById("save-track");
  if (type === false) {
    console.log("igsjgnf");
    target.src = "placeholder-plus.png";
    target.onclick("saveOrRemoveTrack(trackId, true)");
  }
  else if (type === true) {
  target.src = "placeholder-checkmark.png";
  target.onclick("saveOrRemoveTrack(trackId, false)");
  }
}

function saveOrRemoveTrack(trackId, type) {
  console.log("is it making it here")
  const saveUrl = `api/v1/me/save_track?ids=${trackId}&type=${type}`;
  if (type === true) {
  renderSaveButton(trackId, false)
  }
  else {
    renderSaveButton(trackId, true)
  };
  fetch(saveUrl)
    .then(function(response) {
      return response.json();
    })
    .then(function(message){
      console.log(status);
    })
}
