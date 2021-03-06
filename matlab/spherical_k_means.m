function [x]=spherical_k_means(A,M,k,iter_num)
  [n,m]=size(A);
  x = zeros(m,1);

  d = -1;
  for z=1:iter_num
    
    test = zeros(m,k);
    for i=1:m
      for j=1:k
        test(i,j)=transpose(A(:,i))*M(:,j);
      end
    end
    test
  
    % searching of the closest concept vectors and creating new partition
    y=zeros(m,1);
    for i=1:m
        for j=1:k
            if(transpose(A(:,i))*M(:,j)>y(i))
              y(i)=transpose(A(:,i))*M(:,j);
              x(i)=j;
            end
        end
    end
    
    x
    test = zeros(m,k);
    for i=1:m
      for j=1:k
        test(i,j)=transpose(A(:,i))*M(:,j);
      end
    end
    test
  
    % calculating new concept vectors
    M=zeros(n,k);
    for j=1:k
        br=0;
        for i=1:m
            if(x(i)==j)
                M(:,j)=M(:,j)+A(:,i);
                br=br+1;
            end
        end

        if br==0
          M(:,j)=-1*ones(n,1);
        else
          M(:,j)=(1/br)*M(:,j);
        end
        
        % normiranje (kako bi centar ostao na sferi)
        M(:,j) /= sqrt(sum (abs (M(:,j)) .^ 2));
    end
    
    d_stara = d;
    d = objective_function(A, M, x);
    d
    if(d<=d_stara)
      s = 'Break at z='+z;
      printf("Break at k=%d\n", k);
      break;
    end

  end
 
endfunction