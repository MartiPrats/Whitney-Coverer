class RecobrimentWhitney{

  CubWhitney[] cubs;
  CubWhitney[] cubsPeriferics;

  int comptador=0;
  int comptaPeriferics=0;
  Corba linia;
  
  RecobrimentWhitney(Corba liniahereda){
    linia=liniahereda;
    cubs = new CubWhitney[1000*(width+height)];        
    cubsPeriferics = new CubWhitney[1000*(width+height)];
  }

  RecobrimentWhitney(){
    String[] fileLinia = loadStrings(ruta+"/linia.txt");
    String[] fileCubs = loadStrings(ruta+"/cubs.txt");
    String[] fileCubsPeriferics = loadStrings(ruta+"/cubsperiferics.txt");
    String[] fileTalls = loadStrings(ruta+"/talls.txt");
    String[] peces;
    

    vec = new int[1];
    vertexIniciat=true;
    
    comptador=fileCubs.length;
    comptaPeriferics=fileCubsPeriferics.length;
    cubs = new CubWhitney[comptador];
    cubsPeriferics = new CubWhitney[comptaPeriferics];
    
    for(int i=0;i<comptador;i++){
      peces = split(fileCubs[i], '\t');
      if(peces.length == 12){
        cubs[i] = new CubWhitney(float(peces[0]),float(peces[1]),float(peces[2]));
        cubs[i].coloreja(int(peces[3]), int(peces[4]), int(peces[5]), int(peces[6]), int(peces[7]), int(peces[8]), int(peces[9]), int(peces[10]));
        String[] veins = split(peces[11],',');
        for(int j=0; j<veins.length-1;j++){
          cubs[i].veins=append(cubs[i].veins,Integer.parseInt(veins[j]));
        }
      }  
    }
    
    for(int i=0;i<comptaPeriferics;i++){
      peces = split(fileCubsPeriferics[i], '\t');
      if(peces.length == 3){
        cubsPeriferics[i] = new CubWhitney(float(peces[0]),float(peces[1]),float(peces[2]));
//        cubsPeriferics[i].coloreja(255,255,255,100,255,255,255,100);
        cubsPeriferics[i].coloreja(b_r,b_g,b_b,100,b_r,b_g,b_b,100);
      }  
    }
    
    linia = new Corba(fileLinia, fileTalls);
    //alerta - inicialitza variables de control
    components=linia.parts;
    vertexs = new float[components][2];   
    vec = new int[components];
    for(int i=0; i<components;i++)vec[i]=1;
    vertexIniciat=true;
  }
  
  void desa(){
    int veccc=0;
    int ii;
    
    for(int i=0;i<linia.parts;i++) veccc+=linia.vecc[i]; //Computa el total de vèrtexs
    String[] fileLinia = new String[veccc*2];
    String[] fileCubs = new String[comptador];
    String[] fileCubsPeriferics = new String[comptaPeriferics];
    String[] fileTalls = new String[linia.parts];
    int accum=0;
    
    for(int j = 0; j<components; j++){
      ii=0;
      println(linia.vecc[j]);
      for (; ii < linia.vecc[j]*2; ii++) {
        fileLinia[ii+accum] = "" + linia.punts[j][ii];
        println(linia.punts[j][ii]);
      }
      accum +=ii;
      fileTalls[j]= "" + ii;
//      println("A "+j+": "+ fileTalls[j]);
    }
    
    
    for (int i = 0; i < comptador; i++) {
      String veins ="";
      for(int j=0; j<cubs[i].veins.length; j++){
        veins = veins + str(cubs[i].veins[j])+",";
      }
      fileCubs[i] = "" + cubs[i].x_Q + "\t" + cubs[i].y_Q + "\t" + cubs[i].size + "\t" + cubs[i].dins_r + "\t" + cubs[i].dins_g + "\t" + cubs[i].dins_b + "\t" + cubs[i].dins_alpha + "\t" + cubs[i].fora_r + "\t" + cubs[i].fora_g + "\t" + cubs[i].fora_b + "\t" + cubs[i].fora_alpha + "\t" + veins;
    }

    
    for (int i = 0; i < comptaPeriferics; i++) {
      fileCubsPeriferics[i] = "" + cubsPeriferics[i].x_Q + "\t" + cubsPeriferics[i].y_Q + "\t" + cubsPeriferics[i].size;
    }
    
    println("desa");
    
    saveStrings(ruta + "/linia.txt", fileLinia);
    saveStrings(ruta + "/cubs.txt", fileCubs);
    saveStrings(ruta + "/cubsperiferics.txt", fileCubsPeriferics);
    saveStrings(ruta + "/talls.txt", fileTalls);
  }

  void reDibuixa(){
    for(int i=0; i<comptador; i++) cubs[i].pinta();
    fill(b_r,b_g,b_b);
    noStroke();
    for(int i=0; i<comptaPeriferics; i++) cubsPeriferics[i].pinta(); 
    linia.rePinta();  
  }
  
  void dibuixa()
  {  
    recobrintWhitney=true; 
    CubWhitney cubetIterat;
    stroke(0, 60);
  
    for(float i = 0.; i < width; i += mida_max) 
    {
      for(float j = 0.; j < height; j += mida_max) 
      {
        cubetIterat=new CubWhitney(i+mida_max/2,j+mida_max/2,mida_max);
        if(cubetIterat.esDins(linia)) 
        { 
          divisioWhitney(i+mida_max/2,j+mida_max/2,mida_max/2);
        }
        else
        {
          if(cubetIterat.distancia(linia)<sqrt(2)*mida_max) divisioWhitney(i+mida_max/2,j+mida_max/2,mida_max/2);
        }
      }
    }
    
    linia.rePinta();
    detectaVeins();
    recobrintWhitney=false;
  }

  void divisioWhitney(float a, float b, float migDiametreCub)
  {
   CubWhitney cubetIterat;
   if(migDiametreCub<=mida_min)
   {
     cubetIterat=new CubWhitney(a,b, 2*migDiametreCub);
     if(cubetIterat.esDins(linia)){
       cubs[comptador]=cubetIterat;
       if(cubetIterat.distancia(linia)<=2*whitneyConstant*migDiametreCub) cubs[comptador].coloreja(0,0,0,100,0,0,0,100);
       cubs[comptador].pinta();
       comptador+=1;
       
     }
     else{
       cubsPeriferics[comptaPeriferics]=cubetIterat;
       //cubsPeriferics[comptaPeriferics].coloreja(255,255,255,100,255,255,255,100);
       cubsPeriferics[comptaPeriferics].coloreja(b_r,b_g,b_b,100,b_r,b_g,b_b,100);
       cubsPeriferics[comptaPeriferics].pinta();
       comptaPeriferics+=1;
     }

     return;
   }
   
   a=a-migDiametreCub/2;
   b=b-migDiametreCub/2;
   cubetIterat=new CubWhitney(a,b, migDiametreCub);
     if(cubetIterat.distancia(linia)>whitneyConstant*migDiametreCub) 
     {
       if(cubetIterat.esDins(linia)){
         cubs[comptador]=cubetIterat;
         cubs[comptador].pinta();
         comptador+=1;
       }
     }
     else
     {
       divisioWhitney(a,b,migDiametreCub/2); 
     }

   a=a+migDiametreCub;
   cubetIterat=new CubWhitney(a,b, migDiametreCub);
     if(cubetIterat.distancia(linia)>whitneyConstant*migDiametreCub) 
     {
       if(cubetIterat.esDins(linia)){
         cubs[comptador]=cubetIterat;
         cubs[comptador].pinta();
         comptador+=1;
       }
     }
     else
     {
       divisioWhitney(a,b,migDiametreCub/2); 
     }
  
   b=b+migDiametreCub;
   cubetIterat=new CubWhitney(a,b, migDiametreCub);
     if(cubetIterat.distancia(linia)>whitneyConstant*migDiametreCub) 
     {
       if(cubetIterat.esDins(linia)){
         cubs[comptador]=cubetIterat;
         cubs[comptador].pinta();
         comptador+=1;
       }
     }
     else
     {
       divisioWhitney(a,b,migDiametreCub/2); 
     }
  
    a=a-migDiametreCub;
   cubetIterat=new CubWhitney(a,b, migDiametreCub);
     if(cubetIterat.distancia(linia)>whitneyConstant*migDiametreCub) 
     {
       if(cubetIterat.esDins(linia)){
         cubs[comptador]=cubetIterat;
         cubs[comptador].pinta();
         comptador+=1;
       }
     }
     else
     {
       divisioWhitney(a,b,migDiametreCub/2); 
     }

   return;
  }
  
  void localitza(float x, float y)
  {
    for(int i=0; i<comptador;i+=1)
    {
      if(cubs[i].x_sup<=x && x<=cubs[i].x_sup+cubs[i].size&&cubs[i].y_sup<=y && y<=cubs[i].y_sup+cubs[i].size)
      {
        cubs[i].coloreja(color_r, color_g, color_b, color_alpha);
        cubs[i].rePinta();
/*          for(int j=0; j<cubs[i].veins.length; j++){
            cubs[cubs[i].veins[j]].coloreja(color_r, color_g, color_b, color_alpha);
            cubs[cubs[i].veins[j]].rePinta();
          }*/
        
        if(!shadow) return;
        if(!shadowVertical){
          for(int j=0; j<comptador;j+=1)
          {
            if(sqrt(pow(cubs[i].x_Q-cubs[j].x_Q,2)+pow(cubs[i].y_Q-cubs[j].y_Q,2)) < shadowConstant*cubs[i].size)
            {
              cubs[j].coloreja(color_r, color_g, color_b, color_alpha);
              cubs[j].rePinta();       
            }
          }
          return;
        }
        for(int j=0; j<comptador;j+=1)
        {
          if(cubs[i].x_sup<=cubs[j].x_sup && cubs[j].x_sup<cubs[i].x_sup+cubs[i].size&&cubs[j].y_sup>=cubs[i].y_sup+cubs[i].size)
          {
            cubs[j].coloreja(color_r, color_g, color_b, color_alpha);
            cubs[j].rePinta();       
          }
        }
      }
    }
  }
  
  void detectaVeins(){
    for(int  i=0; i<comptador; i++){
      for(int j=i+1; j<comptador; j++){
        if(abs(cubs[i].x_Q-cubs[j].x_Q) <= abs(cubs[i].size+cubs[j].size)/2 && abs(cubs[i].y_Q-cubs[j].y_Q) <= abs(cubs[i].size+cubs[j].size)/2){
          cubs[i].veins=append(cubs[i].veins, j);
          cubs[j].veins=append(cubs[j].veins, i);
        }
      }
    }
  }
}
