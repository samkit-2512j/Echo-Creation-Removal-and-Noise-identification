function peaks_indx = env(x,fs)
    
    peaks_indx=[];
    length_check = 1;
    [~,max_indx] = max(x);
    peaks_indx = [peaks_indx max_indx];
    
    cutoff = x(peaks_indx(1))/25;

    while length_check==1
        lambda =0.000001;
        flag = 1;
        
        lastMax = peaks_indx(end);
        
        while flag==1
            y=[];
            ymax=x(lastMax);
            for i=lastMax:length(x)
                if x(i)>=ymax
                    ymax=x(i);
                    y=[y i];
                else
                    ymax = ymax-ymax*lambda;
                end
            end
            if length(y)>=2
                a=-1000;
                ai = 1;
                for k=2:length(y)

                    if x(y(k))>a && x(y(k)-1)<x(y(k))
                        a=x(y(k));
                        ai = y(k);
                    else
                        continue;
                    end
                end
                flag=0;
            end
            lambda = lambda*1.1;
        end
        if x(ai) >= cutoff && ai>=peaks_indx(end)+0.1*fs
            peaks_indx = [peaks_indx ai];
        else
            length_check=0;
        end

    end
end