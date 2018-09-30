using System;
using System.IO;
using SimpleScanner;
using ScannerHelper;

namespace Main
{
    class mymain
    {
        static void Main(string[] args)
        {
            // Чтобы вещественные числа распознавались и отображались в формате 3.14 (а не 3,14 как в русской Culture)
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");

            var fname = @"..\..\a.txt";
            Console.WriteLine(File.ReadAllText(fname));
            Console.WriteLine("-------------------------");

            Scanner scanner = new Scanner(new FileStream(fname, FileMode.Open));

            int tok = 0;
            //Подсчитать количество, среднюю, минимальную и максимальную длину всех идентификаторов
            int cnt = 0, min = Int32.MaxValue, max = Int32.MinValue, avg = 0;

            //Найти сумму всех целых и сумму всех вещественных в файле
            int sum_int = 0;
            double sum_double = 0;

            do {
                tok = scanner.yylex();
                if (tok == (int)Tok.EOF)
                    break;
                if (tok == (int)Tok.ID) {
                    ++cnt;
                    int l = scanner.yyleng;
                    avg += l;
                    min = Math.Min(min, l);
                    max = Math.Max(max, l);
                }
                if (tok == (int)Tok.INUM)
                    sum_int += Int32.Parse(scanner.yytext);
                if (tok == (int)Tok.RNUM)
                    sum_double += Double.Parse(scanner.yytext);

                Console.WriteLine(scanner.TokToString((Tok)tok));
            } while (true);

            Console.WriteLine();
            Console.WriteLine("Task 2");
            Console.WriteLine("Cnt ID: {0}", cnt);
            Console.WriteLine("Avg length ID: {0}", (avg/cnt));
            Console.WriteLine("Min length ID: {0}     Max length ID: {1}", min, max);
            Console.WriteLine();
            Console.WriteLine("Task 3");
            Console.WriteLine("Sum int: {0}      Sum double: {1}",sum_int, sum_double);



            Console.ReadKey();
        }
    }
}
