function [ giou ] = calcGIOU( A,B )
    %�ֱ��ǵ�һ�������������µ�����
    iou = calcRectInt(A,B);
    x1=A(:,1);
    y1=A(:,2)+A(:,4)-1;
    x2=A(:,1)+A(:,3)-1;
    y2=A(:,2);
    
    x3=B(:,1);
    y3=B(:,2)+B(:,4)-1;
    x4=B(:,1)+B(:,3)-1;
    y4=B(:,2);
    for i=1:5
    area_C(i,:) = (max([x1(i),x2(i),x3(i),x4(i)])-min([x1(i),x2(i),x3(i),x4(i)])).*(max([y1(i),y2(i),y3(i),y4(i)])-min([y1(i),y2(i),y3(i),y4(i)]));
    area_1(i,:) = (x2(i)-x1(i)).*(y1(i)-y2(i));
    area_2(i,:) = (x4(i)-x3(i)).*(y3(i)-y4(i));
    sum_area(i,:) = area_1(i,:) + area_2(i,:);

    w1(i,:) = x2(i) - x1(i);   %��һ�����εĿ�
    w2(i,:)= x4(i) - x3(i) ;  %�ڶ������εĿ�
    h1(i,:) = y1(i) - y2(i);
    h2(i,:) = y3(i) - y4(i);
    W (i,:)= min([x1(i),x2(i),x3(i),x4(i)])+w1(i,:)+w2(i,:)-max([x1(i),x2(i),x3(i),x4(i)])  ;  %���沿�ֵĿ�
    H (i,:)= min([y1(i),y2(i),y3(i),y4(i)])+h1(i,:)+h2(i,:)-max([y1(i),y2(i),y3(i),y4(i)]);    %���沿�ֵĸ�
    end
    Area = W.*H ;   %��������
    add_area = sum_area - Area ;   %�����β��������

    end_area = (area_C - add_area)./area_C ;   %�հ������в����������������ռ�հ�����ı���
    giou = iou - end_area;
end

