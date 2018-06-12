var draw = document.getElementById('draw');
var card = document.getElementById('card');
var shine = document.getElementById('shine');

var shine = document.getElementById('shine');

var creatDiv1 = document.createElement('div');
var creatDiv2 = document.createElement('div');


card.addEventListener('click',drawcard);


function drawcard() {

   card.style.display='none';
   shine.style.display= 'none';

   creatDiv1.className='rank-bg';
   draw.appendChild(creatDiv1);

   creatDiv2.className='character';
   draw.appendChild(creatDiv2);



}
