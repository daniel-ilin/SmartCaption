# SmartCaption

**SmartCaption** app allows the user to get the most fitting caption based on the image they choose. After the user chooses the image from gallery, it is uploaded to **Imagga** servers as a `multipart/form-data` content through their _https://api.imagga.com/v2/uploads_ endpoint. Further a post request with the image ID is made to their _https://api.imagga.com/v2/tags_ endpoint that uses Machine Learning algorythms to provide accurate image tags. These tags are then used in combination with an API call to _http://api.quotable.io/search/quotes_ that receives a number of quotes to find the most fitting one.

**SmartCaption** app was made using MVVM architecture. All of the web requests are made using URLSession API with custom functionality built on top of it allowing to send `multipart/form-data` content in request body.

### Upload photos from gallery

<!-- ![GIF](https://i.imgur.com/C9Jdfak.gif) -->
<img src="https://camo.githubusercontent.com/747d8d30432ffce02e453dcec913d4c7ed10ce6c8c0bd1751c8bb87b29b14cb0/68747470733a2f2f692e696d6775722e636f6d2f43394a6466616b2e676966" data-canonical-src="https://i.imgur.com/C9Jdfak.gif" width="180" height="400" />

### Get image related tags and fitting captions


<p float="left">
  <img
src="https://i.imgur.com/6Hj61AH.gif" data-canonical-src="https://i.imgur.com/6Hj61AH.gif" width="180" height="400" />
<img
src="https://i.imgur.com/E4DT0fy.gif" data-canonical-src="https://i.imgur.com/E4DT0fy.gif" width="180" height="400" />
</p>

Image tagging API provided by
[Imagga](https://imagga.com/)

Quote API provided by 
[LukePeavey: Quotable](https://github.com/lukePeavey/quotable#list-quotes)
