export interface UserProgress {
  questionId: string;
  easeFactor: number;
  interval: number;
  repetitions: number;
  nextReview: number;
}

export interface Question {
  id: string;
  category: string;
  difficulty: "apprentice" | "journeyman" | "master";
  question: string;
  answer: string;
  keywords: string[];
  nec_reference?: string;
}

export interface QuizSession {
  id: string;
  date: number;
  questions: QuizQuestion[];
  score: number;
}

export interface QuizQuestion extends Question {
  userAnswer?: string;
  isCorrect?: boolean;
  points: number;
}
