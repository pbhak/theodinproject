import headerImage from './cafe.jpg';

const homeDiv = document.createElement('div');
const heading = document.createElement('h1');
const description = document.createElement('p');
const image = new Image();


heading.textContent = 'Brew Haven Cafe';

image.src = headerImage;
image.alt = 'Image of the cafe';

description.textContent = `
  Indulge in the cozy charm of our cafe, where every cup is a story, 
  and every bite is a moment of culinary delight, inviting you to savor the joy of 
  exquisite flavors in a warm and inviting atmosphere.
`

document.body.style.backgroundColor = '#111827';
document.body.style.color = 'white';
document.body.style.fontFamily = 'sans-serif';

homeDiv.id = 'home';

homeDiv.appendChild(heading);
homeDiv.appendChild(image);
homeDiv.appendChild(description);

export default homeDiv;