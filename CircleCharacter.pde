class CircleCharacter extends Creature {
  Circle[] circles;
  float t;
  float speed;

  CircleCharacter(float x, float y)
  {
    super(x,y);
  }

  void setup() {
    super.setup();

    this.t = 0;
    this.speed = 1.0;

    int nCircles = 10;
    this.circles = new Circle[nCircles];
    
    for(int i = 0; i < nCircles; i++){
      float phase = map(i, 0, nCircles, 0, TWO_PI / 3.0);
      Circle c = new Circle();
      c.setup(10, 300, 15, phase);
      circles[i] = c;
    }
  }

  void draw(float x, float y) {
    t += speed;
    pushMatrix();
    translate(x, y);

    for (int i=0; i<circles.length; i++ )
    {
        circles[i].draw(t);
    }

    popMatrix();
  }
};

class Circle {
  float phase;
  float minRadius;
  float maxRadius;
  float thickness;

  float prevT;

  void setup(float _minRadius, float _maxRadius, float _thickness, float startPhase) {
    minRadius = _minRadius;
    maxRadius = _maxRadius;
    thickness = _thickness;
    phase = startPhase;

    prevT = 0.0;
  }
  
  void draw(float t) {

    float agitation = map(mouseX, 0, width, 0, 1);
    agitation = pow(agitation, 6.0);

    float dT = t - prevT;
    phase += (dT / 100.0);
    prevT = t;

    float x = sin(phase) + random(agitation / 2.0, agitation);
    float rotation = map(x, -1, 1, 0, TWO_PI / 3.0);
    float radius = map(x, -1, 1, minRadius, maxRadius);
    float stroke = map(x, 0, 1, 0, thickness);
    float alpha = map(x, -1, 1, 80, 180);

    noFill();
    float c1 = random(agitation * 100.0);
    float c2 = random(agitation * 300.0);
//    stroke(255 - c1, 255 - c2, 255 - c2, alpha + agitation * 50.0);
    stroke(255);
    println("Reached here.");

    strokeWeight(abs(thickness - abs(stroke)));

//    ellipse(0, 0, radius * 2.0, radius * 2.0);

    rectMode(CENTER);
    pushMatrix();
    rotate(rotation);
    rect(0, 0, radius * 2.0, radius * 2.0);
    popMatrix();

  }
};

