#include <string.h>
#include <math.h>
#include <stdio.h>
#include <limits.h>

int main()
{
    int m;
    int n;
    scanf("%d %d", &m, &n);

    int a[101][11] = {0};
    int s[10000] = {0};

    for (int i = 1; i <= m; i++)
    {
        char name[50];
        int sum = 0;

        scanf("%s", name);
        if(strlen(name) == 9)printf("%s  ", name);
        if(strlen(name) == 6)printf("%s    ", name);


        for (int j = 1; j <= n; j++)
        {
            int marks;
            scanf("%d", &marks);
            a[i][j] = marks;
            sum += marks;
        }

        printf("%6d", sum);

        for (int k = 1; k <= n; k++)
        {
            printf("%6d", a[i][k]);
        }

        printf("\n");
    }

    printf("average score:");

    for (int p = 1; p <= n; p++)
    {
        int su = 0;

        for (int q = 1; q <= m; q++)
        {
            su += a[q][p];
        }

        printf("%6.1f", su / m);
    }

    return 0;
}