clc
clear

function d = distance(M, center)
 
  
  for k = 1:rows(center);
  
    d1 = (M(:,1)-center(k,1)).^2;
    d2 = (M(:,2)-center(k,2)).^2;
    d3 = (M(:,3)-center(k,3)).^2;
    d4 = (M(:,4)-center(k,4)).^2;
    d(:,k) = d1+d2+d3+d4;
  endfor
  d = sqrt(d);
endfunction

function center = get_center(M,idx,k)
  sum1=0;
  sum2=0;
  sum3=0;
  sum4=0;
  count1 = 0;
  count2 = 0;
  count3 = 0;
  count4 = 0;
  
  for i = 1:rows(M)
    switch (idx(i))
      case 1
        sum1 += M(i,:);
        #disp("class1");
        count1++;
      case 2
        sum2 += M(i,:);
        count2++;
      #disp("class2");
      case 3
        sum3 += M(i,:);
        count3++;
        #disp("class3");
      case 4
          sum4 += M(i,:);
          count4++;
          #disp("class4");
        
    endswitch

  endfor
  
  if(count1 !=0)
    sum1 = sum1/count1;
  endif
  
  if(count2 !=0)
  sum2 = sum2/count2;
  endif
  if(count3 !=0)
  sum3 = sum3/count3;
  endif
  if(count4 !=0)
  sum4 = sum4/count4;
  endif
  center(1,:) = sum1;
  center(2,:) = sum2;
  center(3,:) = sum3;
  center(4,:) = sum4;
endfunction

function rand = get_random(R, k)

   rand = ceil(rand(1,k)*rows(R));
endfunction

function result = classify(M, k)
  #selected = get_random(M, k)
  selected = [42,143,135];
  ini_center = M(selected,:);
   
  dis = distance(M, ini_center);
  [value, idx]=min(dis,[],2);
  idx;
  center = get_center(M,idx,k);
  for i = 1:100
    dis = distance(M, center);
    [value, idx]=min(dis,[],2);
    center = get_center(M,idx,k);  
  endfor
  result = idx;
  
endfunction


filename = "iris1.csv";
R = csvread(filename);
M = R(:,1:4);
 #get_random(R,3)
 #{
  ini_center = M([1,2,3,4],:);
  dis = distance(M, ini_center);
  [value,idx]=min(dis,[],2);
  idx;
  a =[1,2,8;3,4,9;5,6,8;7,1,9]
  idx = [1,2,3,2];
  k = 3;
  center = get_center(a,idx,k)
  #}
  pre_v =classify(M,3);
  
  real_v = R(:,6);
  com(:,1) = pre_v;
  com(:,2) = real_v;
  com;
  right=0;
  class1=0;
  class2=0;
  class3=0;
  class1_r=0;
  class2_r=0;
  class3_r=0;
  for i = 1:150
    if(pre_v(i) ==1)
      class1++;
      if(real_v(i)==pre_v(i))
        class1_r++;
      endif
    endif
    
    if(pre_v(i) ==2)
      class2++;
      if(real_v(i)==pre_v(i))
        class2_r++;
      endif
    endif
    
    if(pre_v(i) ==3)
      class3++;
      if(real_v(i)==pre_v(i))
        class3_r++;
      endif
    endif
    if(pre_v(i)== real_v(i))
      right++;
    endif
      
  endfor

  p_pos = right/150;
  p_neg = 1-p_pos;
  
  p_pos1 = class1_r/class1-0.0001;
  p_neg1 = 1-p_pos1+0.0001;
  
  p_pos2 = class2_r/class2;
  p_neg2 = 1-p_pos2;
  
  p_pos3 = class3_r/class3;
  p_neg3 = 1-p_pos3;

  accuracy = right/150
  entropy = (p_pos1*(-log2(p_pos1)))+p_pos2*(-log2(p_pos2)) +p_pos3*(-log2(p_pos3)) 
 #distance(R,1,1)

