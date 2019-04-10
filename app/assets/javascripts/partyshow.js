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
  console.log(type)
  let target = document.getElementById("save-track");
  if (type === false) {
    target.src = "placeholder-plus.png";
    target.addEventListener('click', function() {
      event.preventDefault();
      saveOrRemoveTrack(trackId, type)
    }, {once: true});
  }
  else if (type === true) {
    target.src = "placeholder-checkmark.png";
    target.addEventListener('click', function(){
      event.preventDefault();
      saveOrRemoveTrack(trackId, type);
    }, {once: true});
  }
}

function saveOrRemoveTrack(trackId, type) {
  const saveUrl = `api/v1/me/save_track?id=${trackId}&type=${type}`;
  console.log(saveUrl)
  fetch(saveUrl)
  .then(function(response) {
    return response.json();
  })
  .then(function(message){
    console.log(message.data.attributes.status);
  });
  if (type === true) {
  renderSaveButton(trackId, false)
  }
  else if (type === false){
    renderSaveButton(trackId, true)
  };
}
