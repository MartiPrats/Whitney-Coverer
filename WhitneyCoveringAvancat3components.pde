PApplet cosa=this;

  float mouseAbansX;
  float mouseAbansY;
  float mouseAraX;
  float mouseAraY;
  boolean locked;
  boolean lloca;
  boolean vertexIniciat=false;
  int componentActiva=0;
  int[] vec;
  int mida_min=1;
  int precisio=1;
  int iterkoch=7;
  int components=1;
  float mida_max;
  int whitneyConstant=4;
  float shadowConstant=10.;
  PVector v=new PVector(); 
  PVector u=new PVector();
  int cubseleccionat=0;
  String ruta;
  Corba liniaBonica;
  RecobrimentWhitney whitneyGrid;
  float[][] vertexs; 
  float[][] koch; 
  float[][] quadrat; 
  float[][] cercle; 
  boolean shadow=false;
  boolean shadowVertical=false;
  boolean recobrintWhitney=false;
  int posicioWhitney=0;
  int color_r=255, color_g=255, color_b=255, color_alpha=255, b_r=255, b_g=255, b_b=255;
  PImage img;

void setup() {
  String lines;

  //img = loadImage("/Users/mprats/Dropbox/Mates-investigacio/Presentacions/imatges/madrid/chotis.jpg");
  //size(1105, 945); 
  //size(1024,512);
  size(768,768);
  //size(1024,768);
  
  background(b_r,b_g,b_b);
  //background(img);
  noFill();
  stroke(0);

  
  locked=false;
  lloca=false;
  mida_max=width/2;
}

void draw() 
{  
 if(lloca && locked)
 { 
   mouseAbansX=pmouseX;
   mouseAbansY=pmouseY;
   mouseAraX=mouseX;
   mouseAraY=mouseY;
   captura();
 }
}

void captura()
{
  if(mouseAbansX==mouseAraX && mouseAbansY==mouseAraY) return;  
  
  line(mouseAraX, mouseAraY, mouseAbansX, mouseAbansY);
  
  vertexs[componentActiva][2*vec[componentActiva]]=mouseAbansX;  
  vertexs[componentActiva][2*vec[componentActiva]+1]=mouseAbansY;
  vec[componentActiva]=vec[componentActiva]+1;
}


void mousePressed()
{ 
  if(components==-1){
    vertexs = new float[1][2];   
    vec = new int[1];
    vec[0]=1;
    vertexIniciat=true;
  }
  if(!vertexIniciat){
    vertexs = new float[components][200*(width+height)];   
    vec = new int[components];
    for(int i=0; i<components; i++) vec[i]=0;
    vertexIniciat=true;
  }
  if(componentActiva<components){
    if(vec[componentActiva]==0){
      locked=true;
    }
  }
  else{
    whitneyGrid.localitza(mouseX, mouseY);
  }  
}

void mouseMoved()
{
  lloca=true;
}

void mouseReleased()
{ 
  if(componentActiva<components){
    mouseAbansX=mouseAraX;
    mouseAbansY=mouseAraY;
    mouseAraX=vertexs[componentActiva][0];
    mouseAraY=vertexs[componentActiva][1];   
    captura();
  }
  if(locked==true) 
  {
    locked=false;
    componentActiva+=1;
    if(componentActiva==components){
      background(b_r,b_g,b_b);
      stroke(0);
      liniaBonica=new Corba(vertexs);
    }
  }
}

void keyPressed() {
  locked=false;
  //K, Q, O per Koch, quadrat i cercle resp.
  //E, L, P per guardar, carregar i imprimir dibuix resp.
  //R, G, B, Y per pintar de colors vermell, verd, blau, groc resp.
  //S per activar shadow, passar a shadow vertical, i tornar a no shadow
  //Espai per pintar de blanc
  //W per fer recobriment WHitney d'una figura.
  
  if(key=='1'||key=='2'||key=='3'){
    components=int(key-48);
    println(components);
  }
  if(key=='K' || key =='k') {
    background(b_r,b_g,b_b);
    stroke(0);
    fractal();
    liniaBonica=new Corba(koch);
//    whitneyGrid=new RecobrimentWhitney(liniaBonica);
//    whitneyGrid.dibuixa();
    noStroke();    
  }
  if(key=='Q' || key =='q') {
    quadrat();
    liniaBonica=new Corba(quadrat);
    whitneyGrid=new RecobrimentWhitney(liniaBonica);
    whitneyGrid.dibuixa();
    background(b_r,b_g,b_b);
    stroke(0);
    for(int i=0; i<whitneyGrid.comptador;i++) whitneyGrid.cubs[i].incrementa(0,-0.16*height);
    for(int i=0; i<whitneyGrid.comptaPeriferics;i++) whitneyGrid.cubsPeriferics[i].incrementa(0,-0.16*height);
    for(int j=0; j<whitneyGrid.linia.parts; j++){
      for(int i=0; i<=whitneyGrid.linia.vecc[j];i++) whitneyGrid.linia.punts[j][2*i+1]-=0.16*height;
    }
    whitneyGrid.reDibuixa();
    noStroke();    
  }
  if(key=='O' || key =='o') {
    background(b_r,b_g,b_b);
    stroke(0);
    cercle();
    liniaBonica=new Corba(cercle);
    componentActiva=7;
//    whitneyGrid=new RecobrimentWhitney(liniaBonica);
//    whitneyGrid.dibuixa();
//    noStroke();    
  }
  if(key=='E' || key =='e') selectFolder("Selecciona una carpeta:", "folderSelectedSave");
  if(key=='L' || key =='l') {
      selectFolder("Selecciona una carpeta:", "folderSelectedLoad");
      delay(2000);
      pintaLoCarregat();
  }
  if(key=='P' || key =='p') selectFolder("Selecciona una carpeta:", "folderSelectedPrint");
  if(key=='R' || key =='r') {
    color_r=150;
    color_g=0;
    color_b=0;
    color_alpha=50;
  }
  if(key=='G' || key =='g'){
    color_r=0;
    color_g=150;
    color_b=0;
    color_alpha=255;
  }
  if(key=='B' || key =='b'){
    color_r=0;
    color_g=0;
    color_b=150;
    color_alpha=50;
  }
  if(key=='Y' || key =='y'){
    color_r=200;
    color_g=200;
    color_b=0;
    color_alpha=50;
  } 
  if(key=='S' || key =='s'){
    if(!shadow){
      shadow=true;
    }
    else{
      if(!shadowVertical){
        shadowVertical=true;
      }
      else{
        shadow=false;
        shadowVertical=false;
      }
    } 
  }
  if(key==' '){
    color_r=255;
    color_g=255;
    color_b=255;
    color_alpha=255;
  }
  if(key=='W' || key =='w') {
    background(b_r,b_g,b_b);
   //  background(img);
    stroke(0);
    whitneyGrid=new RecobrimentWhitney(liniaBonica);
    whitneyGrid.dibuixa();
    noStroke();
  }
}

void folderSelectedLoad(File selection) {
    ruta = null;
    if (selection == null) {
      println("La finestra ha estat tancada");
    } 
    else {
      ruta = selection.getAbsolutePath();
    }
 }
 
 void pintaLoCarregat(){
   while(ruta==null){
    println("Estem esperant...");
    delay(2000);
   }
      println("pintem de blanc");
      background(b_r,b_g,b_b);
      stroke(0);
      whitneyGrid = new RecobrimentWhitney();
      stroke(0,60);
      whitneyGrid.reDibuixa();
      noStroke();

      componentActiva=components;   
 }
 
void folderSelectedSave(File selection) {
    if (selection == null) {
      println("La finestra ha estat tancada");
    } 
    else {
      ruta = selection.getAbsolutePath();
      whitneyGrid.desa();
    }
 }
 
void folderSelectedPrint(File selection) {
    if (selection == null) {
      println("La finestra ha estat tancada");
    } 
    else {
      ruta = selection.getAbsolutePath();
      saveFrame(ruta + "/whitney####.png");
    }
 }
