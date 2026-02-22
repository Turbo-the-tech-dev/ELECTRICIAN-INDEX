/**
 * Calculate a match score based on keyword presence in transcription.
 * 
 * @param transcription - The text to search within
 * @param keywords - Array of keywords to search for
 * @returns Score percentage (0-100) based on how many keywords are found
 */
export function calculateScore(transcription: string, keywords: string[]): number {
  // Handle edge cases
  if (!transcription || transcription.trim() === '' || keywords.length === 0) {
    return 0;
  }

  // Convert transcription to lowercase for case-insensitive matching
  const lowerTranscription = transcription.toLowerCase();

  // Count how many keywords are found (as substrings)
  let matchCount = 0;
  for (const keyword of keywords) {
    if (lowerTranscription.includes(keyword.toLowerCase())) {
      matchCount++;
    }
  }

  // Calculate percentage score
  const score = (matchCount / keywords.length) * 100;
  
  return score;
}
