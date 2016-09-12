class Animal{
  DNAPointer P;
  int t;
  ArrayList sections = new ArrayList();
  ArrayList headCells = new ArrayList();
  FanCell fanCell = new FanCell();
  
  int read(int p){
    P = new DNAPointer(p);
    
    t = P.getValue();
    P.getNextValue();
    
    if (t % 2 == 0){
      while (sections.size() < 4 && count < MAX_CELLS){
        Section section = new Section();
        sections.add(section);
        P.p = section.read(P.p);
        if (P.getNextValue() == 0) break;
      }
    }
    else
    {
      P.p = fanCell.read(P.p);
    }
    
    
    // add the head
    int c = P.getNextValue();
    c = c % 4;
    //c = max(c,1);
    for (int i = 0; i < c; i++){
      Cell cell = new HeadCell();
      headCells.add(cell);
    }
    
    return P.p;
  }
  
  void draw(){
    noStroke();
    
    fill(255);
    
    // head
    pushMatrix();
    stroke(1);
    line(0,0,0,-S_LINE,0,0);
    translate(-S_LINE,0,0);
    //scale(-1,2);
    rotateZ(PI);
    //scale(1,2);
    for (int i = 0; i < headCells.size(); i++){
      
      HeadCell cell = (HeadCell) headCells.get(i);
      cell.draw();
    }
    popMatrix();
    
    fill(255);
    
    // body
    if (t % 2 == 0){
      for (int i = 0; i < sections.size(); i++){
        Section section = (Section) sections.get(i);
        section.draw();
      }
    }
    else
    {
      fanCell.draw();
    }
  }
}

class Section{
  DNAPointer P;
  ArrayList cells = new ArrayList();

  int read(int p){    
    P = new DNAPointer(p);
  
    int c = P.getValue();
    int t = P.getNextValue();
    
    c = max(c,1);
    
    for (int i = 0; i < c; i++){
      Cell cell;
      
      if (t % 2 == 0) cell = new BasicCell();
      else cell = new CrossCell();
      
      cells.add(cell); 
      count++;
      
      if (count >= MAX_CELLS) return P.p;
    }
    
    int o = P.getNextValue();
    if (o % 2 == 1) doOverride();
    else P.getNextValue();
    
    // read each cross cell read 
    int maxP = P.p;
    int tempP;
    for (int i = 0; i < cells.size(); i++){
      Cell cell = (Cell) cells.get(i);
      if (cell.classType == "CrossCell")
      {
        tempP = cell.read(P.p);
        maxP = max(tempP, maxP);
      }
    }
    P.p = maxP;
    return P.p;
  }
  
  void doOverride()
  {
    int maxC = cells.size();
    int i = 0;
    
    int c = P.getNextValue();
    i = c;
    while ((i-1) < maxC && c != 0){
      
      if (cells.get(i-1).classType == "CrossCell")  cells.set(i-1, new BasicCell());
      else cells.set(i-1, new CrossCell());
      
      c = P.getNextValue();
      i+= c;
    }
    
    if (c == 0) P.getNextValue();
  }
  
  void draw(){
    noStroke();
    for (int i =0; i < cells.size(); i++){
      Cell cell = (Cell) cells.get(i);
      cell.draw();
    }
  }
}

class Cell{
  DNAPointer P;
  string classType = "";
  
  int read(int p){
    P = new DNAPointer(p);
    return P.p;
  }
  
  void draw(){}
}

class HeadCell extends Cell{

  HeadCell()
  {
    super();
    classType = "HeadCell";
  }
  
  void draw(){
    noStroke();
    //ellipse(0,0, S*1.5, S*1.5);
    sphere(S*1.5);
    stroke(1);
    line(0, 0,0, S*1.5, 0,0);
    translate(S*1.5,0,0);
  }
}

class BasicCell extends Cell{
  float angle = 0;
  
  BasicCell()
  {
    super();
    classType = "BasicCell";
  }
  
  void draw(){
    noStroke();
    //rect(0,0, S, S);
    rotateY(angle);
    box(S);
    stroke(1);
    line(0, 0, 0, S_LINE, 0, 0);
    translate(S_LINE,0, 0);
  }
  
  void setAngle(float a){
    angle = a;
  }
}

class CrossCell extends Cell{
  ArrayList cells1 = new ArrayList();
  ArrayList cells2 = new ArrayList();
  float angle1 = 0;
  float angle2 = 0;
  float angle3 = 0;
  float angle;
  
  CrossCell()
  {
    super();
    classType = "CrossCell";
  }
  
  int read(int p){
    P = new DNAPointer(p);
    
    int c = P.getValue();
    int t = P.getNextValue();
    int a1 = P.getNextValue();
    int a2 = P.getNextValue();
    int a3 = P.getNextValue();
    
    c = c % 5;
    
    a1 = a1 % 5;
    angle1 = -QUARTER_PI/2f + (a1 * QUARTER_PI / 4f);
    
    a2 = a2 % 5;
    angle2 = -QUARTER_PI/2f + (a2 * QUARTER_PI / 4f);
    
    a3 = a3 % 5;
    angle3 = -QUARTER_PI/2f + (a3 * QUARTER_PI / 4f);
    
    angle = 0f;
    
    for(int i = 0; i < c; i++){
      BasicCell cell1 = new BasicCell();
      BasicCell cell2 = new BasicCell();
      
      int a = P.getNextValue();
      a = a % 5;
      float aa = -QUARTER_PI/2f + (a3 * QUARTER_PI / 4f);
      
      angle += aa;
      
      cell1.setAngle(angle);
      cell2.setAngle(angle);
      
      cells1.add(cell1);
      count++;
      
      cells2.add(cell2);
      count++;
      
      if (count >= MAX_CELLS) return P.p;
    }
   
    if (t % 2 == 1 ){
      int maxP = 0;
      int tempP;
      Cell cell1 = new FanCell();
      Cell cell2 = new FanCell();
      
      cells1.add(cell1);
      count++;
      
      cells2.add(cell2);
      count++;
      
      if (count >= MAX_CELLS) return P.p;
      

      tempP = cell1.read(P.p);
      maxP = max(tempP, maxP);

      tempP = cell2.read(P.p);
      maxP = max(tempP, maxP);
      
      P.p = maxP;
      
      if (count >= MAX_CELLS) return P.p;
    }
   
    return P.p;
  }
  
  void draw(){
    noStroke();
    //rect(0,0, S, S);
    box(S);
    stroke(1);
    line(0, 0, 0, S_LINE, 0, 0);
    
    
    pushMatrix();
    rotateZ(-HALF_PI);
    //rotateX(-angle1);
    //rotateY(angle2);
    rotateZ(angle1);
    rotateY(angle2);
    rotateX(-angle3);
    line(0,0,0,S_LINE,0,0);
    translate(S_LINE,0);
    for (int i =0; i< cells1.size(); i++){
      Cell cell = (Cell) cells1.get(i);
      cell.draw();
    }
    popMatrix();
    
    pushMatrix();
    rotateZ(HALF_PI);
    //rotateX(angle1);
    //rotateY(HALF_PI-angle2);
    rotateZ(-angle1);
    rotateY(angle2);
    rotateX(angle3);
    line(0,0,0,S_LINE,0,0);
    translate(S_LINE,0,0);
    for (int i =0; i< cells2.size(); i++){
      Cell cell = (Cell) cells2.get(i);
      cell.draw();
    }
    popMatrix();
    
    translate(S_LINE,0);
  }
}

class FanCell extends Cell{
  ArrayList fan = new ArrayList();
  float a;
  
  FanCell()
  {
    super();
    classType = "FanCell";
  }
  
  int read(int p){
    P = new DNAPointer(p);
    
    int c1 = P.getNextValue();
    int c2 = P.getNextValue();
    a = P.getNextValue();
    
    
    c1 = c1 % 10;
    c2 = c2 % 5;
    
    c1 = max(c1, 3);
    
    
    int a = P.getNextValue();
    a = a % 5;
    float aa = -QUARTER_PI / 4f  + (a * QUARTER_PI / 8f);
    
    for(int i1 = 0; i1 < c1; i1++){
      ArrayList f = new ArrayList();
      fan.add(f);
      
      for (int i2=0; i2<c2; i2++){
        BasicCell cell = new BasicCell();
        cell.setAngle(aa);
        
        f.add(cell);
        count++;
      }
    }
    
    return P.p;
  }
  
  void draw(){
    noStroke();
    //rect(0,0, S, S);
    box(S);

    a = a + 1;
    a = a / 10f;
    a = a * PI;

    float totalAngle = a;
    float startAngle = totalAngle / 2f;
    float deltaAngle = fan.size() > 1 ?  totalAngle / (float)(fan.size()-1) : 0f;
    if (fan.size() <= 1) startAngle = 0;
    
    pushMatrix();
    rotateZ(startAngle);

    for (int i1 =0; i1 < fan.size(); i1++){

      ArrayList f = (ArrayList) fan.get(i1);
      pushMatrix();
      stroke(1);
      line(0,0,0,S_LINE,0,0);
      translate(S_LINE, 0,0);
      for(int i2 =0; i2< f.size(); i2++){
        Cell cell = (Cell) f.get(i2);
        cell.draw();
      }
      popMatrix();
      rotateZ(-deltaAngle);
    }
    
    popMatrix();
  }
}
