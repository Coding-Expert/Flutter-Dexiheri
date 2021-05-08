class APIpath {
  static String job(String uid, String jobId) => 'jobs/$uid/jobs/$jobId';
  static String jobs(String uid) => 'jobs/$uid/jobs';
  static String xristis(String uid) => 'users/$uid';
  static String eggrafo(String uid, String eggrafoId) => 'eggrafa/$uid/eggrafa/$eggrafoId';
  static String eggrafoTimologisi(String uid, String kodikosKatastimatosId) => 'eggrafaTimologisis/$uid/katastimata/$kodikosKatastimatosId';
  static String eggrafaTimologisi(String uid) => 'eggrafaTimologisis/$uid/katastimata';
}
