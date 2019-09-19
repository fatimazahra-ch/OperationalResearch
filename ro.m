contraint=input('Donner le nombre de contraintess : '); % La variable Qui stocke le nombre des contraintes .

%==============================================================
      % La saisie Des Donn�es ::
%==============================================================

    A=zeros(contraint,2);
    for i= 1:contraint
        for j= 1:2
            A(i,j) = input(' ');
        end
        SI(i)=input('Sup�rieur taper 1 si Inferieur taper 0'); % Ca c'est un Tableau Pour enregistrer les < ou > pour chaque Contrainte .
        b(i)=input(' ');
    end
    
    % On r�cup�re le maximum des contraints , on est besoin de Ca pour le
    % dessin des droits .
    a=max(b);
    
    %Formulation du fonction objective
    disp(' Donner la fonction Objective : ')
    for i=1:2
        z(i)=input(' ');
    end

    %Le Choix Du Type De Probl�me : test(0/1).
    test=input('Est ce qu il s agit d un probl�me de Minimisation/Maximisation :  Maximisation Tapez 1 / Minimisation Tapez 0');
    
    
 %==============================================================
      % Les Traitements ::
 %=============================================================
 
    % Calcul de Maximum des Y
     Maxy = 0;
     for i=1:contraint
           x=0:2:a; % l'interval ou l'eshell de mesure pour X
           y=(1/A(i,2))*(b(i)-A(i,1).*x);
           if( (A(i,1)~=0) && (A(i,2)~=0))
               if( max(y) > Maxy)
                   Maxy = max(y);
               end
           end 
     end

     %Chercher Le minimum des Y
     Miny =Maxy;
     for i=1:contraint
           x=0:2:a;
           y=(1/A(i,2))*(b(i)-A(i,1).*x);
           if( (A(i,1)~=0) && (A(i,2)~=0))
               if( min(y) < Miny)
                   Miny = min(y);
               end 
           end    
     end
%Remarque :
    % G�n�ralement on est besoin de ces traitements , c'�d le maximum des Y
    % plus le minimum des Y seulement pour le dessin des droites .
    
    
    
%*******************************************************************
%*******************************************************************

    % Si il s'agit d'un probl�me de maximisation
    
%*******************************************************************
%*******************************************************************

    if(test == 1)
       %Une boucle pour le Trasage des droites 
       for i=1:contraint
            x=0:2:a*a;
            %==============================================================
            
            if( A(i,1)==0)  % Equation Sous Forme A(i,2)Y=b(i) ==> Les coefficient de X est Nul Voil� ce Qu'on va faire
                 if(SI(i)==0) % Inferieur <<
                    patch([0,max(x),max(x),0],[b(i)/A(i,2),b(i)/A(i,2),Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'green')
                    hold on
                 end
                 if(SI(i)==1) %Sup�rieur >>
                    patch([0,max(x),max(x),0],[Miny*2,Miny*2,b(i)/A(i,2),b(i)/A(i,2)],[0,0,0,0],'red')
                    hold on
                 end
            end
            
            %==============================================================
            
            if( A(i,2)==0) % Equation Sous Forme A(i,1)X=b(i) ==> Voil� ce Qu'on va faire
                    if(SI(i)==0) % Inferieur <<
                       patch([b(i)/A(i,1),max(x),max(x),b(i)/A(i,1)],[Miny*2,Miny*2,Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'green')
                       hold on
                    end
                    if(SI(i)==1) %Sup�rieur >>
                       patch([0,b(i)/A(i,1),b(i)/A(i,1),0],[Miny*2,Miny*2,Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'red')
                       hold on
                    end
            end

          %==============================================================
       
            if( (A(i,1)~=0) && (A(i,2)~=0))
                y=(1/A(i,2))*(b(i)-A(i,1).*x);
                area(x,y,Maxy+1,'FaceColor',[0 1 0])
                hold on
                xlim([min(x),max(x)])
                ylim([min(y)-1,max(y)+1])
            end
       end
   
    
       % Tracage de la droite de marge nulle Delta o
       y3 = -(z(1)/z(2))*x;
       plot(x,y3,'yellow')
   
%*******************************************************************
%*******************************************************************

    % Si il s'agit d'un probl�me de minimisation
    
%*******************************************************************
%*******************************************************************

    else  %test != 1 Obligatoirement == 0
       x=0:2:a*a;
       %Une boucle pour le Trasage des droites 
       for i=1:contraint
           
         %==============================================================
         
         if( A(i,1)==0)  % Equation Sous Forme A(i,2)Y=b(i) ==> Les coefficient de X est Nul Voil� ce Qu'on va faire
             if(SI(i)==0) % Inferieur <<
                patch([0,max(x),max(x),0],[b(i)/A(i,2),b(i)/A(i,2),Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'green')
                hold on
             end
             if(SI(i)==1) %Sup�rieur >>

                patch([0,max(x),max(x),0],[Miny*2,Miny*2,b(i)/A(i,2),b(i)/A(i,2)],[0,0,0,0],'red')
                hold on
             end
         end
        
        %==============================================================
        if( A(i,2)==0)% Equation Sous Forme A(i,1)X=b(i) ==> Voil� ce Qu'on va faire
            
                if(SI(i)==0) % Inferieur <<
                patch([b(i)/A(i,1),max(x),max(x),b(i)/A(i,1)],[Miny*2,Miny*2,Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'green')
                hold on
                end
                
               if(SI(i)==1) %Sup�rieur >>
                 patch([0,b(i)/A(i,1),b(i)/A(i,1),0],[Miny*2,Miny*2,Maxy*Maxy,Maxy*Maxy],[0,0,0,0],'red')
                 hold on
              end
 
        end
        
        %==============================================================
        if( (A(i,1)~=0) && (A(i,2)~=0))
                y=(1/A(i,2))*(b(i)-A(i,1).*x);
                area(x,y,Miny,'FaceColor',[1 0 0])
                hold on
                xlim([min(x),max(x)])
                ylim([min(y)-1,max(y)+1])
        end
       end
       
       % Tracage de la droite de marge nulle  Delta o
       y3 = -(z(1)/z(2))*x;
       plot(x,y3,'yellow')
       end
       
 %==============================================================
      % Fin Des Traitements ::
 %=============================================================  
  
%D�termination des Points extr�mes dans l'ensemble des solutions r�alisables 
%D�termination de la solution optimal


   
   


   
 