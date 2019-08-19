<h2>Magic Arena Arena Draft Helper</h2>

<h3>Current Live App:</h3>
http://magicarenahelper.herokuapp.com/

<h3>In Progress...</h3>

<h3>Technologies:</h3>
Ruby on Rails, React.js, Redux, Google Vision, Google Spreadsheets, Nokogiri

<h3>Current Functionality:</h3>
<ul>
  <li>JavaScript image uploader implemented in React</li>
  <li>Image is sent by Rails back-end to Google Vision API</li>
  <li>Card Database is seeded from Scryfall API</li>
  <li>Data is pulled from players' tier lists via Google Spreadsheets, web crawlers, and from text files then seeded into the Postgres database</li>
  <li>Text is extracted from image. It is processed and matched to the database's card names using a fuzzy matcher due to Google Vision OCR imperfection</li>
  <li>All API connections are authenticated and functional on Heroku. Currently you can upload an image and it will pull card information from the image, and compare it with the seeded card database. Then, it will send card names, information, ratings, and images to the front end to be displayed. (No styling yet) Here is a sample image to test it out with and see the result: https://drive.google.com/file/d/12Biqw3pjinbcWVtN5bGNpUhppgo2QyFR/</li>
</ul>

<h3>Upcoming:</h3>
<ul>
  <li>App will present you which cards are best/worst picks according to various community tier lists</li>
  <li>Styling <- currently in progress</li>
  <li>Error checking and much more user feedback</li>
  <li>Front end testing</li>
  <li>D3 graphing information for expansions and individual card packs</li>
  <li>Random pack generator just for kicks?</li>
</ul>
