class Corba{
  
  //PShape forma;
  int parts;
  int[] vecc;
  float[][] punts;
  
  
  Corba(float[][] vertexs){
    parts = vertexs.length;
    punts = new float[parts][200*(width+height)]; 
    vecc = new int[parts];
    for(int i=0; i<parts; i++){
      vecc[i] = 0;
      for(int j=0;j<vec[i]-1; j++)
      { 
        segment(vertexs[i][2*j], vertexs[i][2*j+1], vertexs[i][2*j+2], vertexs[i][2*j+3],i);
      }
      ////tanquem la corba:
      segment(vertexs[i][2*vec[i]-2], vertexs[i][2*vec[i]-1], vertexs[i][0], vertexs[i][1],i);
    }  
  }
  
  Corba(String[] fileLinia, String[] fileTalls){
    parts = fileTalls.length;
    punts = new float[parts][200*(width+height)]; 
    vecc = new int[parts];
    int i;
    int accum=0;
    
    //OJU si fa bé la conversió d'una linia de caràcters a numero enter. Revisar
    for(int ii=0; ii<parts;ii++){
      vecc[ii]=int(fileTalls[ii])/2;
    }
    
    punts = new float[parts][fileLinia.length];
    
    for(int j=0; j<parts; j++){
      i=0;
      for(;i<int(fileTalls[j]);i+=1){
        punts[j][i] = float(fileLinia[i+accum]);
      }
      accum+=i;
    }
    
//    for(int i=1; i<fileLinia.length-2; i+=2){
//        line(punts[i],punts[i+1],punts[i+2],punts[i+3]);
//    }
  }

/////////  Alternativa amb PShape???
  /*Corba(float[] punts, int i){
    forma = createShape();
    forma.beginShape();
    forma.stroke(0);
    for(int j=0;j<i-1; j++)
    { 
      float dd=dist(punts[2*j], punts[2*j+1], punts[2*j+2], punts[2*j+3]);
      if(dd>mida_min)
      {
        for(float k=0; k<precisio*dd; k+=mida_min)
        {
          forma.vertex(punts[2*j]+k*(punts[2*j+2]-punts[2*j])/(precisio*dd),punts[2*j+1]+k*(punts[2*j+3]-punts[2*j+1])/(precisio*dd));
          punts[2*vecc]=punts[2*j]+k*(punts[2*j+2]-punts[2*j])/(precisio*dd);
          punts[2*vecc+1]=punts[2*j+1]+k*(punts[2*j+3]-punts[2*j+1])/(precisio*dd);
          vecc+=1;          
        }
      }
      else
      {
          forma.vertex(punts[2*j],punts[2*j+1]);
          punts[2*vecc]=punts[2*j];
          punts[2*vecc+1]=punts[2*j+1];
          vecc+=1;          
      }
    }
    forma.endShape(CLOSE);
  }*/

  void segment(float ax, float ay, float bx, float by, int compoNow){
    //dibuixa la línia
    line(ax,ay,bx,by);
      
    //creem els punts intermitjos per fer fiables la funció distància i la funció esDins.
    float dd=dist(ax,ay,bx,by);

    if(dd>mida_min)
    {
      for(float k=0; k<precisio*dd; k+=mida_min)
      {
        punts[compoNow][2*vecc[compoNow]]=ax+k*(bx-ax)/(precisio*dd);
        punts[compoNow][2*vecc[compoNow]+1]=ay+k*(by-ay)/(precisio*dd);
        vecc[compoNow]+=1;          
      }
    }
    else
    {
        punts[compoNow][2*vecc[compoNow]]=ax;
        punts[compoNow][2*vecc[compoNow]+1]=ay;
        vecc[compoNow]+=1;          
    }
    
  }


  void rePinta() 
  {  
    stroke(0);
    for(int j=0; j<parts; j++){
      println(2*vecc[j]);
      for(int i=0; i<2*vecc[j]-2; i+=2){
        line(punts[j][i],punts[j][i+1],punts[j][i+2],punts[j][i+3]);
//        println(""+punts[j][i]+",    "+punts[j][i+1]+",    "+punts[j][i+2]+",    "+punts[j][i+3]);
      }
    }

//    shape(forma);
  }


 /* void pintaFora()
  {
    CubWhitney cubetIterat;
    noStroke();
    fill(255);
          
    
    for(int i=0;i<cubsPeriferics.length/2;i++){
      if(!cubsPeriferics[i].esDins(this)){
        cubsPeriferics[i].pinta();
        println(i);
      }
    }
    stroke(0);
  }*/
  
/*  void desa(){
  void desa(){ 
    corbeta = createWriter("linies.txt");
    for(int i=0;i<vec; i++)
    {
      corbeta.println("punts[2*i],punts[2*i+1]");
    }
  }

  void carrega(){
  }*/
  
}