class OnboardingItem {
  final String question;
  final String hint;
  final List<String>? options;  // Add a list of options for questions that require multiple choices.

  OnboardingItem({
    required this.question,
    required this.hint,
    this.options,  // This will be used for questions like "What is the purpose of using Arrive?"
  });
}

final List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    question: "What should we call you?",
    hint: "First name",
  ),
  OnboardingItem(
    question: "What is your age?",
    hint: "",
  ),
  OnboardingItem(
    question: "What is the purpose of using Arrive?",
    hint: "",
    options: [

    ],  // Add options for the third question
  ),
  OnboardingItem(
    question: "",
    hint: "",
  ),
  OnboardingItem(
    question: "",
    hint: "",
  ),
];
