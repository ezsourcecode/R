# factor(팩터): 범주형 데이터(질적 데이터)를 관리하는 구조
## 명목형과 서열형
## factor(x, levels, ordered)

str(iris)
v_c = c('사과', '복숭아', '사과', '오렌지', '사과', '오렌지', '복숭아')
str(v_c)
v_factor = factor(v_c) #서열이 있으면 levels, ordered 인수도 있어야 함#
v_factor
str(v_factor)
mode(v_factor) # 팩터로 바꾸면 numeric으로 자료형태가 바뀜
typeof(v_factor)

# is~(~입니까), as~(~로 캐스팅하다)
## numeric(integer, double-소수점 있음), character, logical, complex
## 자료형 확인: mode(), typeof()

is.numeric(v_factor) # numeric이나 실수가 아닌 정수라 integer. 하지만 완벽한 형변환이 안 되어 FALSE가 출력됨
as.character(v_factor)
str(v_factor)
is.character(v_factor) #as로 형변환을 시도해도 변환이 안 됨. factor는 다른 형태의 자료형으로 봐야 함

v_factor = as.character(v_factor)
is.character(v_factor) # 함수를 실행하고 변환값을 저장해야 문자형으로 바뀐 걸 확인할 수 있다

## 팩터 확인
v_factor

v_num = as.numeric(v_factor)
v_num
