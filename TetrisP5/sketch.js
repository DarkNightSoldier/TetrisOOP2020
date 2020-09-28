// T tetromino rotations encoded as suggested last time
const T = [58, 154, 184, 178];
// T tetromino properties
let tColor;
let tRotation;

function setup() {
  createCanvas(600, 600);
  tColor = color('#ff007d');
  tRotation = 0;
}

function draw() {
  background(0, 255, 0);
  drawT();
}

function drawT() {
  push();
  strokeWeight(5);
  fill(tColor);
  for (i = 0; i <= 8; i++) {
    if ((T[tRotation] & (1 << (8 - i))) != 0) {
      rect((i % 3) * width / 3, ((i / 3) | 0) * height / 3, width / 3, height / 3);
    }
  }
  pop();
}

function keyPressed() {
  if (keyCode === UP_ARROW) {
    tRotation--;
  } else if (keyCode === DOWN_ARROW) {
    tRotation++;
  }
  tRotation = tRotation < 0 ? 3 : tRotation % 4;
}