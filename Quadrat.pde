void quadrat() {
  int longitudmax=min(width,height);
  
  components=1;
  vec = new int[1];
  vertexIniciat=true;

  quadrat = new float[1][10]; 

  quadrat[0][0] = 0.5*longitudmax;
  quadrat[0][1] = longitudmax;
  quadrat[0][8] = 0.5*longitudmax;
  quadrat[0][9] = longitudmax;
  quadrat[0][2] = 1.5*longitudmax;
  quadrat[0][3] = 0;
  quadrat[0][4] = 0.5*longitudmax;
  quadrat[0][5] = -1*longitudmax;
  quadrat[0][6] = -0.5*longitudmax;
  quadrat[0][7] = -0;
  vec[0] = 5;
}