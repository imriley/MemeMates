# Meme Soulmate

## Concept

Meme Soulmate is a mobile application that facilitates unique connections through shared humor and musical preferences. Users express themselves via meme-based mood boards and personalized anthems, fostering a fun and engaging way to find potential soulmates.

## Features

- **User Authentication:** Secure user registration and login using Firebase Authentication.
- **Social Profile Creation:** Users create profiles with basic information, preferences (age range, gender), and an optional profile picture.
- **Mood Board Design:** A core feature where users express themselves through a customizable mood board using uploaded memes or personal photos.
- **Music Integration:** Users can choose a profile anthem by searching for a song or generating one using AI. They can also select a specific song segment (intro/chorus).
- **Discovery & Matching:** Users browse profiles through a horizontal swiping interface, similar to Tinder. Profiles showcase mood boards and allow anthem autoplay for a more immersive experience.
- **Meme-Centric Communication:** Communication starts with memes or music snippets, encouraging a unique and lighthearted approach to breaking the ice. AI suggestions for memes based on user profiles or past interactions can enhance engagement.
- **Messaging & Interaction:** After an initial exchange of memes or music, users can unlock text chat functionality. Additional features like daily meme exchange streaks and meme/mood board-based conversation prompts can add a layer of fun.
- **Premium Features (Optional):** Consider offering a subscription model with benefits like AI-curated matches, custom anthem/meme creation, enhanced profile visibility, in-app purchases for themed stickers or meme templates for messaging.
- **Notifications:** Timely notifications can keep users engaged (e.g., new matches, meme streak reminders, profile activity updates).
- **Settings & Account Management:** Users can edit profiles, manage connections and chats, adjust content preferences, and control privacy settings. Secure account management features like log out or account deactivation are essential.

## Getting Started

1. **Clone the repository:**

   ```bash
   git clone https://github.com/imriley/MemeMates.git
   ```

2. **Set up Firebase:**

   - Create a Firebase project in the Firebase console.
   - Install the FlutterFire CLI:

     ```bash
     dart pub global activate flutterfire_cli
     ```

   - Run `flutterfire configure` and follow the on-screen instructions. This will:
   - Create a Firebase app in your Firebase project.
   - Generate a `firebase_options.dart` file in your `lib` directory.
   - Configure your Android and/or iOS app to use Firebase.

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

**Note:** This README provides a high-level overview. Specific implementation details will vary depending on your chosen functionalities.

## Further Development

- Implement detailed UI screens and functionalities based on the features outlined.
- Integrate Firebase Authentication and Cloud Firestore for user data management.
- Explore AI-powered features for music suggestions and meme recommendations.
- Consider implementing a robust matching algorithm based on user profiles, mood boards, and music preferences.

This project has the potential to be a fun and engaging way for users to connect. By leveraging Flutter's capabilities and Firebase's backend services, you can create a unique and user-friendly app experience.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
