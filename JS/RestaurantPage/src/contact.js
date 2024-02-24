const infoDiv = document.createElement('div');
const heading = document.createElement('h1');
const description = document.createElement('p');

heading.textContent = 'Contact';

description.textContent = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'

infoDiv.id = 'contact';
infoDiv.style.display = 'none';

infoDiv.appendChild(heading);
infoDiv.appendChild(description);

export default infoDiv;