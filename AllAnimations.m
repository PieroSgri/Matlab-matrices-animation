
% Progetto Corso Elettrotecnica - Università Politecnica delle Marche
% Piero Sgrignuoli  1072841

%{
 ALCUNI TEMPLATE PER COMODITA

 plot3(Uomo.X, Uomo.Y, Uomo.Z, '.')
 xlabel('Asse X'); ylabel('Asse Y'); zlabel('Asse Z');

 plot3((:,1), (:,2), (:,3), 'b.'); hold on; 

 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'b.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on;       
 plot3(GambaDx(:,1), GambaDx(:,2), GambaDx(:,3), 'b.'); hold on;
 plot3(GambaSx(:,1), GambaSx(:,2), GambaSx(:,3), 'b.'); hold on;    
 plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'b.'); hold on;  
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'b.'); hold on;
%}


while (1)
m = menu('Scegliere l''animazione da visualizzare','Saluto', 'Camminata sul Posto', 'Sollevamento Scatola','Chiudi');
switch m
    
    case 2
        
clearvars; close all;
load('C:\Università\Progettto ELE\Uomo3D.mat');

%%%%%% IL SEGUENTE BLOCCO SERVE SOLO PER IMPOSTARE I PARAMETRI DEL GRAFICO %%%%%%

    plot3(Uomo.X,Uomo.Y,Uomo.Z); hold on;
    title('Camminata');
    xlabel('Asse X'); ylabel('Asse Y'); zlabel('Asse Z');
    xlim([-120 120]); ylim([-70 70]); zlim([-40 200]);
    view(-10, 5); 
    delete(findobj(gca,'Type','line'));        
        
 %%%%%% PER LA EUL2ROTM SPECIFICARE GLI ASSI COME [Z Y X] NON COME ORDINE CLASSICO [X Y Z] %%%%%%

 EuleroBraccioDx = [0 +pi/2.5 0];
 RotBDx = eul2rotm(EuleroBraccioDx);

 EuleroBraccioSx = [0 -pi/2.5 0];
 RotBSx = eul2rotm(EuleroBraccioSx);

 %%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%
 BraccioDx = ((BraccioDx-RefBraccioDx)*RotBDx) + RefBraccioDx;
 BraccioSx = ((BraccioSx-RefBraccioSx)*RotBSx) + RefBraccioSx;
 %%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%
 

flag=1;
Ripetizioni=0;

while Ripetizioni<3

  while flag==1
      
  EuleroGambaDxSup = [0 0 +pi/120];
  RotGDxSup = eul2rotm(EuleroGambaDxSup);

  EuleroGambaSxSup = [0 0 -pi/120];
  RotGSxSup = eul2rotm(EuleroGambaSxSup);
  
  EuleroGambaDxInf = [0 0 +pi/120];
  RotGDxInf = eul2rotm(EuleroGambaDxInf);

  EuleroGambaSxInf = [0 0 -pi/110];
  RotGSxInf = eul2rotm(EuleroGambaSxInf);
  
  EuleroBraccioDx = [0 0 -pi/120];
  RotBDx = eul2rotm(EuleroBraccioDx);

  EuleroBraccioSx = [0 0 +pi/120];
  RotBSx = eul2rotm(EuleroBraccioSx);
  
  GambaDxSup = (GambaDxSup - RefGambaDx)*RotGDxSup + RefGambaDx;
  RefGambaDxSup = GambaDxSup(end,:);
  GambaDxInf = ((GambaDxInf - RefGambaDxSup)*RotGDxInf) + ((RefGambaDxSup - RefGambaDx)*RotGDxSup) + RefGambaDx;
  
  GambaSxSup = (GambaSxSup - RefGambaSx)*RotGSxSup + RefGambaSx;
  RefGambaSxSup = GambaSxSup(end,:);
  GambaSxInf = ((GambaSxInf - RefGambaSxSup)*RotGSxInf) + ((RefGambaSxSup - RefGambaSx)*RotGSxSup) + RefGambaSx;
  
  BraccioDx = (BraccioDx - RefBraccioDx)*RotBDx + RefBraccioDx;
  BraccioSx = (BraccioSx - RefBraccioSx)*RotBSx + RefBraccioSx;

  %%%%%% INSERIMENTO ANIMAZIONI %%%%%%     
  
  delete(findobj(gca, 'Color', 'b'));
  delete(findobj(gca, 'Color', [0 0.4 1]));
  
  plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
  plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on;  
  
  plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
 
  plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  
  plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
  plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
  
  pause(0.02);
  
  %%%%%% CHECK DEI LIMITI DI ANIMAZIONE %%%%%%
  
  check = any(GambaDxInf(:,2)<(-35));
    if check==true
       flag=0;
    end
  end
 
 
  while flag==0
  
  EuleroGambaDxSup = [0 0 -pi/120];
  RotGDxSup = eul2rotm(EuleroGambaDxSup);

  EuleroGambaSxSup = [0 0 +pi/120];
  RotGSxSup = eul2rotm(EuleroGambaSxSup);

  EuleroGambaDxInf = [0 0 -pi/110];
  RotGDxInf = eul2rotm(EuleroGambaDxInf);

  EuleroGambaSxInf = [0 0 +pi/120];
  RotGSxInf = eul2rotm(EuleroGambaSxInf);
  
  EuleroBraccioDx = [0 0 +pi/120];
  RotBDx = eul2rotm(EuleroBraccioDx);

  EuleroBraccioSx = [0 0 -pi/120];
  RotBSx = eul2rotm(EuleroBraccioSx);
   
  GambaDxSup = (GambaDxSup - RefGambaDx)*RotGDxSup + RefGambaDx;
  RefGambaDxSup = GambaDxSup(end,:);
  GambaDxInf = ((GambaDxInf - RefGambaDxSup)*RotGDxInf) + ((RefGambaDxSup - RefGambaDx)*RotGDxSup) + RefGambaDx;
  
  GambaSxSup = (GambaSxSup - RefGambaSx)*RotGSxSup + RefGambaSx;
  RefGambaSxSup = GambaSxSup(end,:);
  GambaSxInf = ((GambaSxInf - RefGambaSxSup)*RotGSxInf) + ((RefGambaSxSup - RefGambaSx)*RotGSxSup) + RefGambaSx;
  
  BraccioDx = (BraccioDx - RefBraccioDx)*RotBDx + RefBraccioDx;
  BraccioSx = (BraccioSx - RefBraccioSx)*RotBSx + RefBraccioSx;

  %%%%%% INSERIMENTO ANIMAZIONI %%%%%%

  delete(findobj(gca, 'Color', 'b'));
  delete(findobj(gca, 'Color', [0 0.4 1]));
  
  plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
  plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on;  
  
  plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
 
  plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color',  [0 0.4 1], 'Marker', '.'); hold on;
  
  plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
  plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
  
  pause(0.02);
  
  %%%%%% CHECK DEI LIMITI DI ANIMAZIONE %%%%%%
  
  check = any(GambaSxInf(:,2)<(-35));
    if check==true
       flag=1;
    end   
  end
 
 Ripetizioni=Ripetizioni+1;
 
end

    case 3
        
clearvars; close all;
load('C:\Università\Progettto ELE\Uomo3D.mat');

%%%%%% IL SEGUENTE BLOCCO SERVE SOLO PER IMPOSTARE I PARAMETRI DEL GRAFICO %%%%%%

    plot3(Uomo.X,Uomo.Y,Uomo.Z); hold on;
    title('Sollevamento Scatola');
    xlabel('Asse X'); ylabel('Asse Y'); zlabel('Asse Z');
    xlim([-200 200]); ylim([-120 120]); zlim([-30 220]);
    view(-20, 5); 
    delete(findobj(gca,'Type','line'));        
        
%%%%%% PER LA EUL2ROTM SPECIFICARE GLI ASSI COME [Z Y X] NON COME ORDINE CLASSICO [X Y Z] %%%%%%

 EuleroBraccioDx = [0 +pi/2.6 0];
 RotBDx = eul2rotm(EuleroBraccioDx);

 EuleroBraccioSx = [0 -pi/2.6 0];
 RotBSx = eul2rotm(EuleroBraccioSx);

 %%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%
 BraccioDx = ((BraccioDx-RefBraccioDx)*RotBDx) + RefBraccioDx;
 BraccioSx = ((BraccioSx-RefBraccioSx)*RotBSx) + RefBraccioSx;
 %%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%
 
 j = 0;
 
 patch(p1(:,1),p1(:,2),p1(:,3), [0.54  0.27  0.07]);
 patch(p2(:,1),p2(:,2),p2(:,3), [0.54  0.27  0.07]);
 patch(p3(:,1),p3(:,2),p3(:,3), [0.54  0.27  0.07]);
 patch(p4(:,1),p4(:,2),p4(:,3), [0.54  0.27  0.07]);
 patch(p5(:,1),p5(:,2),p5(:,3), [0.54  0.27  0.07]);
 patch(p6(:,1),p6(:,2),p6(:,3), [0.54  0.27  0.07]);
 
 for i=1:10
 
 j = j+1;
 
 EuleroGambe = [0 0 +pi/50];
 RotGambe = eul2rotm(EuleroGambe);
 
 GambaDxSup = (GambaDxSup - RefGambaDxSup)*RotGambe + RefGambaDxSup;
 GambaSxSup = (GambaSxSup - RefGambaSxSup)*RotGambe + RefGambaSxSup;
 
 Testa(:,3) = Testa(:,3)-2;
 Testa(:,2) = Testa(:,2)+0.8;
 BraccioDx(:,3) = BraccioDx(:,3)-2;
 BraccioDx(:,2) = BraccioDx(:,2)+0.8;
 BraccioSx(:,3) = BraccioSx(:,3)-2;
 BraccioSx(:,2) = BraccioSx(:,2)+0.8;
 Torso(:,3) = Torso(:,3)-2;
 Torso(:,2) = Torso(:,2)+0.8;
 
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
 delete(findobj(gca, 'Color', [0 0.5 1]));
 
 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on; 
 
 plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 
 if j == 1
     pause(1.5);
 end
 
 pause(0.01);
 
 end   
 
 for i=1:30
 
 EuleroGenerale = [0 0 -pi/100];
 RotGen = eul2rotm(EuleroGenerale);
 
 EuleroBraccia = [0 0 +pi/100];
 RotBraccia = eul2rotm(EuleroBraccia);
 
 RefGenerale = Torso(1,:);
 Testa = (Testa - RefGenerale)*RotGen + RefGenerale;
 Torso = (Torso - RefGenerale)*RotGen + RefGenerale;
 
 BraccioDx = (BraccioDx - RefGenerale)*RotGen + RefGenerale;
 BraccioSx = (BraccioSx - RefGenerale)*RotGen + RefGenerale; 
 
 RefBraccioDx = BraccioDx(1,:);
 RefBraccioSx = BraccioSx(1,:);
 BraccioDx = (BraccioDx - RefBraccioDx)*RotBraccia + RefBraccioDx;
 BraccioSx = (BraccioSx - RefBraccioSx)*RotBraccia + RefBraccioSx;
  
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
 delete(findobj(gca, 'Color', [0 0.5 1]));
 
 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on; 
 
 plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 
 pause(0.01)
 
 end
 
 for i=1:30
 
 EuleroGenerale = [0 0 +pi/100];
 RotGen = eul2rotm(EuleroGenerale);
 
 EuleroBraccia = [0 0 -pi/100];
 RotBraccia = eul2rotm(EuleroBraccia);
 
 RefGenerale = Torso(1,:);
 Testa = (Testa - RefGenerale)*RotGen + RefGenerale;
 Torso = (Torso - RefGenerale)*RotGen + RefGenerale;
 
 BraccioDx = (BraccioDx - RefGenerale)*RotGen + RefGenerale;
 BraccioSx = (BraccioSx - RefGenerale)*RotGen + RefGenerale; 
 
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
 delete(findobj(gca, 'Color', [0 0.5 1]));
 delete(findobj(gca, 'Type', 'patch'));
 
 p1(:,3) = p1(:,3)+1;
 p2(:,3) = p2(:,3)+1;
 p3(:,3) = p3(:,3)+1;
 p4(:,3) = p4(:,3)+1;
 p5(:,3) = p5(:,3)+1;
 p6(:,3) = p6(:,3)+1;
 
 patch(p1(:,1),p1(:,2),p1(:,3), [0.54  0.27  0.07]);
 patch(p2(:,1),p2(:,2),p2(:,3), [0.54  0.27  0.07]);
 patch(p3(:,1),p3(:,2),p3(:,3), [0.54  0.27  0.07]);
 patch(p4(:,1),p4(:,2),p4(:,3), [0.54  0.27  0.07]);
 patch(p5(:,1),p5(:,2),p5(:,3), [0.54  0.27  0.07]);
 patch(p6(:,1),p6(:,2),p6(:,3), [0.54  0.27  0.07]);

 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on; 
 
 plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 
 pause(0.01)
 
 end
 
 
 for i=1:10
  
 EuleroGambe = [0 0 -pi/50];
 RotGambe = eul2rotm(EuleroGambe);
 
 GambaDxSup = (GambaDxSup - RefGambaDxSup)*RotGambe + RefGambaDxSup;
 GambaSxSup = (GambaSxSup - RefGambaSxSup)*RotGambe + RefGambaSxSup;
 
 Testa(:,3) = Testa(:,3)+2;
 Testa(:,2) = Testa(:,2)-0.8;
 BraccioDx(:,3) = BraccioDx(:,3)+2;
 BraccioDx(:,2) = BraccioDx(:,2)-0.8;
 BraccioSx(:,3) = BraccioSx(:,3)+2;
 BraccioSx(:,2) = BraccioSx(:,2)-0.8;
 Torso(:,3) = Torso(:,3)+2;
 Torso(:,2) = Torso(:,2)-0.8;
 
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
 delete(findobj(gca, 'Color', [0 0.5 1]));
 delete(findobj(gca, 'Type', 'patch'));
 
 p1(:,3) = p1(:,3)+1.7;
 p2(:,3) = p2(:,3)+1.7;
 p3(:,3) = p3(:,3)+1.7;
 p4(:,3) = p4(:,3)+1.7;
 p5(:,3) = p5(:,3)+1.7;
 p6(:,3) = p6(:,3)+1.7;
 
 p1(:,2) = p1(:,2)-0.5;
 p2(:,2) = p2(:,2)-0.5;
 p3(:,2) = p3(:,2)-0.5;
 p4(:,2) = p4(:,2)-0.5;
 p5(:,2) = p5(:,2)-0.5;
 p6(:,2) = p6(:,2)-0.5;
 
 patch(p1(:,1),p1(:,2),p1(:,3), [0.54  0.27  0.07]);
 patch(p2(:,1),p2(:,2),p2(:,3), [0.54  0.27  0.07]);
 patch(p3(:,1),p3(:,2),p3(:,3), [0.54  0.27  0.07]);
 patch(p4(:,1),p4(:,2),p4(:,3), [0.54  0.27  0.07]);
 patch(p5(:,1),p5(:,2),p5(:,3), [0.54  0.27  0.07]);
 patch(p6(:,1),p6(:,2),p6(:,3), [0.54  0.27  0.07]);
 
 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on; 
 
 plot3(GambaDxSup(:,1), GambaDxSup(:,2), GambaDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxSup(:,1), GambaSxSup(:,2), GambaSxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(GambaDxInf(:,1), GambaDxInf(:,2), GambaDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSxInf(:,1), GambaSxInf(:,2), GambaSxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on; 
 
 plot3(BraccioDx(:,1), BraccioDx(:,2), BraccioDx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.5 1], 'Marker', '.'); hold on;
 
 pause(0.005);
 
 end 
 
    case 1
        
clearvars; close all;
load('C:\Università\Progettto ELE\Uomo3D.mat');

%%%%%% IL SEGUENTE BLOCCO SERVE SOLO PER IMPOSTARE I PARAMETRI DEL GRAFICO %%%%%%

    plot3(Uomo.X,Uomo.Y,Uomo.Z); hold on;
    title('Saluto');
    xlabel('Asse X'); ylabel('Asse Y'); zlabel('Asse Z');
    xlim([-120 120]); ylim([-70 70]); zlim([-40 200]);
    view(0, 5); 
    delete(findobj(gca,'Type','line'));        
        
%%%%%% PER LA EUL2ROTM SPECIFICARE GLI ASSI COME [Z Y X] NON COME ORDINE CLASSICO [X Y Z] %%%%%%

EuleroBraccioDx = [0 -pi/2.5 0];
RotBDx = eul2rotm(EuleroBraccioDx);

EuleroBraccioDx2 = [-pi/2.5 0 0];
RotBDx2 = eul2rotm(EuleroBraccioDx2);

EuleroBraccioSx = [0 -pi/2.5 0];
RotBSx = eul2rotm(EuleroBraccioSx);

%%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%
BraccioDxSup = ((BraccioDxSup - RefBraccioDx)*RotBDx) + RefBraccioDx;
BraccioDxSup = ((BraccioDxSup - RefBraccioDx)*RotBDx2) + RefBraccioDx;
BraccioDxInf = ((BraccioDxInf - RefBraccioDx)*RotBDx) + RefBraccioDx;
BraccioDxInf = ((BraccioDxInf - RefBraccioDx)*RotBDx2) + RefBraccioDx;
BraccioSx = ((BraccioSx-RefBraccioSx)*RotBSx) + RefBraccioSx;
BraccioDxSup(:,3) = BraccioDxSup(:,3) -3;
BraccioDxInf(:,3) = BraccioDxInf(:,3) -3;
%%%%%% QUESTO BLOCCO POSIZIONA SEMPLICEMENTE LE BRACCIA %%%%%%

for i = 1:3
for j = 1:10
    
 EuleroBraccioDxSup = [0 -pi/140 0];
 RotBDxSup = eul2rotm(EuleroBraccioDxSup);
 
 EuleroBraccioDxInf = [0 -pi/40 0];
 RotBDxInf = eul2rotm(EuleroBraccioDxInf);
 
 BraccioDxSup = (BraccioDxSup - RefBraccioDx)*RotBDxSup + RefBraccioDx;
 RefBraccioDxSup = BraccioDxSup(1,:);
 BraccioDxInf = ((BraccioDxInf - RefBraccioDxSup)*RotBDxInf) + ((RefBraccioDxSup - RefBraccioDx)*RotBDxSup) + RefBraccioDx;
  
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
  
 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on;  
 
 plot3(GambaDx(:,1), GambaDx(:,2), GambaDx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSx(:,1), GambaSx(:,2), GambaSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 
 plot3(BraccioDxInf(:,1), BraccioDxInf(:,2), BraccioDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(BraccioDxSup(:,1), BraccioDxSup(:,2), BraccioDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 
 pause(0.05);
  
end 
  
for k = 1:10 
 EuleroBraccioDxSup = [0 +pi/140 0];
 RotBDxSup = eul2rotm(EuleroBraccioDxSup);
 
 EuleroBraccioDxInf = [0 +pi/40 0];
 RotBDxInf = eul2rotm(EuleroBraccioDxInf);
 
 BraccioDxSup = (BraccioDxSup - RefBraccioDx)*RotBDxSup + RefBraccioDx;
 RefBraccioDxSup = BraccioDxSup(1,:);
 BraccioDxInf = ((BraccioDxInf - RefBraccioDxSup)*RotBDxInf) + ((RefBraccioDxSup - RefBraccioDx)*RotBDxSup) + RefBraccioDx;
 
 delete(findobj(gca, 'Color', 'b'));
 delete(findobj(gca, 'Color', [0 0.4 1]));
  
 plot3(Testa(:,1), Testa(:,2), Testa(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 plot3(Torso(:,1), Torso(:,2), Torso(:,3), 'b.'); hold on;  
 
 plot3(GambaDx(:,1), GambaDx(:,2), GambaDx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(GambaSx(:,1), GambaSx(:,2), GambaSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;  
 
 plot3(BraccioSx(:,1), BraccioSx(:,2), BraccioSx(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 
 plot3(BraccioDxInf(:,1), BraccioDxInf(:,2), BraccioDxInf(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
 plot3(BraccioDxSup(:,1), BraccioDxSup(:,2), BraccioDxSup(:,3), 'Color', [0 0.4 1], 'Marker', '.'); hold on;
  
 pause(0.05);
  
end 
end
    
    case 4
        break; 

end
end

close all