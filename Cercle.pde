void cercle() {
  int longitudmax=min(width,height);
  float c_x = width/2, c_y=height/2, r=0.45*longitudmax;
  int passos = floor (2 * 3.14159 * r / precisio);
  
  components=7;
  vertexIniciat=true;
  vec = new int[components];
    
  cercle = new float[components][2*passos+4]; 
  
  circumferencia(0,c_x,c_y,r, passos);
  circumferencia(1,c_x,c_y,r/6, passos/6);
  circumferencia(2,c_x + r/2,c_y,r/12, passos/12);
  circumferencia(3,c_x + 3*r/4,c_y,r/24, passos/24);
  circumferencia(4,c_x + 7*r/8,c_y,r/48, passos/48);
  circumferencia(5,c_x + 15*r/16,c_y,r/96, passos/96);
  circumferencia(6,c_x + 31*r/32,c_y,r/192, passos/192);
//  circumferencia(7,c_x,c_y,r*6, 6*passos);
}

void circumferencia(int j, float centrex, float centrey, float radi, int passets){
  float angle = 0;
  float increm = 2 * 3.14159/passets;

  for(int i = 0; angle < 2 * 3.14159; angle += increm){
    cercle[j][2*i] = centrex + radi * cos(angle);
    cercle[j][2*i+1] = centrey + radi * sin(angle);
    i++;
    vec[j]=i;
  }
  cercle[j][2*vec[0]] = centrex+radi;
  cercle[j][2*vec[0]+1] = centrey;
}