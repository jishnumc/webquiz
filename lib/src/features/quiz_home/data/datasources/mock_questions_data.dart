import '../models/quiz_question_model.dart';

/// Statically defined list of 20 high-fidelity questions for the quiz application.
const List<QuizQuestionModel> mockQuestionsList = [
  QuizQuestionModel(
    id: 1,
    questionText:
        'A train passes a station platform in 36 seconds and a man standing on the platform in 20 seconds. If the speed of the train is 54 km/hr, what is the length of the platform?',
    options: ['120 m', '240 m', '300 m', 'None of these'],
    explanation:
        'Speed = 54 * (5/18) = 15 m/sec. Length of train = 15 * 20 = 300 m. Let length of platform be L. (300 + L)/15 = 36 => 300 + L = 540 => L = 240 m.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 2,
    questionText:
        'A sum of money at simple interest amounts to Rs. 815 in 3 years and to Rs. 854 in 4 years. The sum is:',
    options: ['Rs. 650', 'Rs. 690', 'Rs. 698', 'Rs. 700'],
    explanation:
        'Interest for 1 year = Rs. (854 - 815) = Rs. 39. Interest for 3 years = Rs. (39 x 3) = Rs. 117. Principal = Rs. (815 - 117) = Rs. 698.',
    correctOptionIndex: 2,
  ),
  QuizQuestionModel(
    id: 3,
    questionText:
        'The simple interest on a certain sum of money for 2(1/2) years at 12% per annum is Rs. 40 less than the simple interest on the same sum for 3(1/2) years at 10% per annum. Find the sum.',
    options: ['Rs. 800', 'Rs. 600', 'Rs. 750', 'Rs. 900'],
    explanation:
        'Let the sum be x. Then, (x * 10 * 3.5)/100 - (x * 12 * 2.5)/100 = 40. 35x - 30x = 4000 => 5x = 4000 => x = Rs. 800.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 4,
    questionText:
        'A, B and C can do a piece of work in 20, 30 and 60 days respectively. In how many days can A do the work if he is assisted by B and C on every third day?',
    options: ['12 days', '15 days', '16 days', '18 days'],
    explanation:
        'A\'s 2 days work = 2/20 = 1/10. (A+B+C)\'s 1 day work = 1/20 + 1/30 + 1/60 = 1/10. 3 days work = 1/10 + 1/10 = 1/5. Hence work is done in 15 days.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 5,
    questionText:
        'A train 125 m long passes a man, running at 5 km/hr in the same direction in which the train is going, in 10 seconds. The speed of the train is:',
    options: ['45 km/hr', '50 km/hr', '54 km/hr', '55 km/hr'],
    explanation:
        'Speed of train relative to man = 125/10 = 12.5 m/sec = 12.5 * (18/5) = 45 km/hr. Since they are in the same direction, speed of train = 45 + 5 = 50 km/hr.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 6,
    questionText:
        'Two trains of equal length are running on parallel lines in the same direction at 46 km/hr and 36 km/hr. The faster train passes the slower train in 36 seconds. The length of each train is:',
    options: ['50 m', '72 m', '80 m', '82 m'],
    explanation:
        'Relative speed = 46 - 36 = 10 km/hr = 10 * (5/18) = 25/9 m/sec. Total distance = 2L. 2L = (25/9) * 36 = 100 m => L = 50 m.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 7,
    questionText:
        'A person crosses a 600 m long street in 5 minutes. What is his speed in km per hour?',
    options: ['3.6 km/hr', '7.2 km/hr', '8.4 km/hr', '10 km/hr'],
    explanation:
        'Speed = 600 / (5 * 60) = 2 m/sec. Converting to km/hr = 2 * (18/5) = 7.2 km/hr.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 8,
    questionText:
        'If a person walks at 14 km/hr instead of 10 km/hr, he would have walked 20 km more. The actual distance travelled by him is:',
    options: ['50 km', '56 km', '70 km', '80 km'],
    explanation:
        'Let distance be x. Time = x/10 = (x + 20)/14 => 14x = 10x + 200 => 4x = 200 => x = 50 km.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 9,
    questionText:
        'A train can travel 50% faster than a car. Both start from point A at the same time and reach point B 75 kms away from A at the same time. On the way, however, the train lost about 12.5 minutes while stopping at the stations. The speed of the car is:',
    options: ['100 km/hr', '110 km/hr', '120 km/hr', '130 km/hr'],
    explanation:
        'Let car speed be x. Train speed is 1.5x. 75/x - 75/1.5x = 12.5/60 => 25/x = 5/24 => x = 120 km/hr.',
    correctOptionIndex: 2,
  ),
  QuizQuestionModel(
    id: 10,
    questionText:
        'Excluding stoppages, the speed of a bus is 54 km/hr and including stoppages, it is 45 km/hr. For how many minutes does the bus stop per hour?',
    options: ['9 minutes', '10 minutes', '12 minutes', '15 minutes'],
    explanation:
        'Due to stoppages, it covers 9 km less per hour. Time taken to cover 9 km = 9/54 = 1/6 hour = 10 minutes.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 11,
    questionText:
        'A sum of money outstanding at compound interest amounts to Rs. 5290 in 2 years and to Rs. 6083.50 in 3 years. The rate of interest per annum is:',
    options: ['15%', '12%', '10%', '8%'],
    explanation:
        'Interest on 5290 for 1 year = 6083.50 - 5290 = Rs. 793.50. Rate = (793.50 * 100) / 5290 = 15%.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 12,
    questionText:
        'The compound interest on Rs. 30,000 at 7% per annum is Rs. 4,347. The period (in years) is:',
    options: ['1 year', '2 years', '3 years', '4 years'],
    explanation:
        'Amount = 30000 + 4347 = 34347. 34347 = 30000 * (1.07)^n => 1.1449 = 1.07^n => n = 2 years.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 13,
    questionText:
        'If the simple interest on a sum of money for 2 years at 5% per annum is Rs. 50, what is the compound interest on the same at the same rate and for the same time?',
    options: ['Rs. 51.25', 'Rs. 52.00', 'Rs. 50.50', 'None of these'],
    explanation:
        'Sum = (50 * 100) / (5 * 2) = Rs. 500. CI = 500 * [(1 + 0.05)^2 - 1] = 500 * 0.1025 = Rs. 51.25.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 14,
    questionText:
        'The difference between simple and compound interest on Rs. 1625 for 2 years at 4% per annum is:',
    options: ['Rs. 1.20', 'Rs. 2.00', 'Rs. 2.60', 'Rs. 3.00'],
    explanation:
        'Difference = P * (R/100)^2 = 1625 * (4/100)^2 = 1625 * 0.0016 = Rs. 2.60.',
    correctOptionIndex: 2,
  ),
  QuizQuestionModel(
    id: 15,
    questionText:
        'What will be the compound interest on a sum of Rs. 25,000 after 3 years at the rate of 12% per annum?',
    options: ['Rs. 9000.00', 'Rs. 10123.20', 'Rs. 10120.00', 'Rs. 9850.50'],
    explanation:
        'Amount = 25000 * (1.12)^3 = 25000 * 1.404928 = Rs. 35123.20. CI = 35123.20 - 25000 = Rs. 10123.20.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 16,
    questionText:
        'A bank offers 5% per annum compound interest calculated on half-yearly basis. A customer deposits Rs. 1600 each on 1st January and 1st July of a year. At the end of the year, the amount he would have gained by way of interest is:',
    options: ['Rs. 121', 'Rs. 120', 'Rs. 122', 'Rs. 123'],
    explanation:
        'Amount = 1600 * (1 + 0.025)^2 + 1600 * (1 + 0.025) = 1600 * 1.050625 + 1640 = 1681 + 1640 = 3321. Deposit = 3200. Interest = Rs. 121.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 17,
    questionText:
        'The difference between compound interest and simple interest on a sum of money at 8% per annum for 2 years is Rs. 4. Find the sum.',
    options: ['Rs. 500', 'Rs. 600', 'Rs. 625', 'Rs. 650'],
    explanation:
        'P * (8/100)^2 = 4 => P * 0.0064 = 4 => P = 4 / 0.0064 = Rs. 625.',
    correctOptionIndex: 2,
  ),
  QuizQuestionModel(
    id: 18,
    questionText:
        'In what time will Rs. 1000 become Rs. 1331 at 10% per annum compounded annually?',
    options: ['2 years', '3 years', '4 years', '5 years'],
    explanation:
        '1331 = 1000 * (1.1)^n => 1.331 = 1.1^n => (1.1)^3 = 1.1^n => n = 3 years.',
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    id: 19,
    questionText:
        'Albert invested an amount of Rs. 8000 in a fixed deposit scheme for 2 years at compound interest rate 5% per annum. How much amount will Albert get on maturity of the fixed deposit?',
    options: ['Rs. 8820', 'Rs. 8800', 'Rs. 8850', 'Rs. 8900'],
    explanation:
        'Maturity Amount = 8000 * (1.05)^2 = 8000 * 1.1025 = Rs. 8820.',
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    id: 20,
    questionText:
        'The compound interest on a certain sum for 2 years at 10% per annum is Rs. 525. The simple interest on the same sum for double the time at half the rate percent per annum is:',
    options: ['Rs. 400', 'Rs. 500', 'Rs. 600', 'None of these'],
    explanation:
        'P * [(1.1)^2 - 1] = 525 => P * 0.21 = 525 => P = 2500. New time = 4 years, New rate = 5%. SI = (2500 * 4 * 5)/100 = Rs. 500.',
    correctOptionIndex: 1,
  ),
];
