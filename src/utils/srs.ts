import type { UserProgress } from '../types';

// SRS Algorithm Constants
const DEFAULT_EASE_FACTOR = 2.5;
const MIN_EASE_FACTOR = 1.3;
const INITIAL_INTERVAL = 1;
const SECOND_INTERVAL = 6;
const SUCCESS_THRESHOLD = 3;
const MAX_PERFORMANCE_RATING = 5;
const MILLISECONDS_PER_DAY = 24 * 60 * 60 * 1000;

// Performance Score Thresholds
const SCORE_THRESHOLDS = {
  EXCELLENT: 90,
  GOOD: 70,
  PASS: 50,
  POOR: 30,
  BAD: 10,
};

// Performance Ratings
const PERFORMANCE_RATINGS = {
  EXCELLENT: 5,
  GOOD: 4,
  PASS: 3,
  POOR: 2,
  BAD: 1,
  FAIL: 0,
};

export const calculateNextReview = (
  performance: number, // 0 to 5
  previousProgress?: UserProgress
): UserProgress => {
  let {
    easeFactor = DEFAULT_EASE_FACTOR,
    interval = 0,
    repetitions = 0
  } = previousProgress || {};

  if (performance >= SUCCESS_THRESHOLD) {
    if (repetitions === 0) {
      interval = INITIAL_INTERVAL;
    } else if (repetitions === 1) {
      interval = SECOND_INTERVAL;
    } else {
      interval = Math.round(interval * easeFactor);
    }
    repetitions++;
  } else {
    repetitions = 0;
    interval = INITIAL_INTERVAL;
  }

  // SM-2 Algorithm for updating ease factor
  // EF = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
  easeFactor = easeFactor + (0.1 - (MAX_PERFORMANCE_RATING - performance) * (0.08 + (MAX_PERFORMANCE_RATING - performance) * 0.02));

  if (easeFactor < MIN_EASE_FACTOR) easeFactor = MIN_EASE_FACTOR;

  const nextReview = Date.now() + interval * MILLISECONDS_PER_DAY;

  return {
    questionId: previousProgress?.questionId || '',
    easeFactor,
    interval,
    repetitions,
    nextReview
  };
};

export const scoreToPerformance = (score: number): number => {
  if (score >= SCORE_THRESHOLDS.EXCELLENT) return PERFORMANCE_RATINGS.EXCELLENT;
  if (score >= SCORE_THRESHOLDS.GOOD) return PERFORMANCE_RATINGS.GOOD;
  if (score >= SCORE_THRESHOLDS.PASS) return PERFORMANCE_RATINGS.PASS;
  if (score >= SCORE_THRESHOLDS.POOR) return PERFORMANCE_RATINGS.POOR;
  if (score >= SCORE_THRESHOLDS.BAD) return PERFORMANCE_RATINGS.BAD;
  return PERFORMANCE_RATINGS.FAIL;
};
