# SmartCaption

**SmartCaption** app allows the user to get the most fitting caption based on the image they choose. After the user chooses the image from gallery, it is uploaded to **Imagga** servers as a `multipart/form-data` content through their _https://api.imagga.com/v2/uploads_ endpoint. Further a post request with the image ID is made to their _https://api.imagga.com/v2/tags_ endpoint that uses Machine Learning algorythms to provide accurate image tags. These tags are then used in combination with an API call that receives a number of quotes to find the most fitting one.

**SmartCaption** app was made using MVVM architecture. All of the web requests are made using URLSession API with custom functionality built on top of it allowing to send `multipart/form-data` content in request body.

<iframe class="imgur-embed" width="100%" height="1299" frameborder="0" src="https://i.imgur.com/xHxk9ZT.gifv#embed"></iframe>
