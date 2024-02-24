const menuDiv = document.createElement('div');
const heading = document.createElement('h1');
const description = document.createElement('p');

heading.textContent = 'Menu';

description.textContent = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'

menuDiv.id = 'menu';
menuDiv.style.display = 'none';

menuDiv.appendChild(heading);
menuDiv.appendChild(description);

export default menuDiv;