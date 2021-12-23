# SmartCaption

**SmartCaption** app allows the user to get the most fitting caption based on the image they choose. After the user chooses the image from gallery, it is uploaded to **Imagga** servers as a `multipart/form-data` content through their _https://api.imagga.com/v2/uploads_ endpoint. Further a post request with the image ID is made to their _https://api.imagga.com/v2/tags_ endpoint that uses Machine Learning algorythms to provide accurate image tags. These tags are then used in combination with an API call that receives a number of quotes to find the most fitting one.

**SmartCaption** app was made using MVVM architecture. All of the web requests are made using URLSession API with custom functionality built on top of it allowing to send `multipart/form-data` content in request body.

### Upload photos from gallery

<!-- ![GIF](https://i.imgur.com/C9Jdfak.gif) -->
<img src="https://camo.githubusercontent.com/747d8d30432ffce02e453dcec913d4c7ed10ce6c8c0bd1751c8bb87b29b14cb0/68747470733a2f2f692e696d6775722e636f6d2f43394a6466616b2e676966" data-canonical-src="https://i.imgur.com/C9Jdfak.gif" width="200" height="400" />

### Get image related tags and fitting captions


<p float="left">
  <img
src="https://camo.githubusercontent.com/442a18e11c2e80b81a11798273067d352d8f7d39db3ef0f43fdb05b4b586aeef/68747470733a2f2f692e696d6775722e636f6d2f50396c343058662e676966" data-canonical-src="https://i.imgur.com/P9l40Xf.gif" width="200" height="400" />
<img
src="https://camo.githubusercontent.com/12e0b2a16799a9fe35a4f65b2c6d1749df59df059a8e157635299a20e7ac4ecd/68747470733a2f2f692e696d6775722e636f6d2f756e4b4d6e596f2e676966" data-canonical-src="https://i.imgur.com/unKMnYo.gif" width="200" height="400" />
</p>
