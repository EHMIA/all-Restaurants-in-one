# Restaurant Review Feature Implementation

## Overview

This implementation adds a complete review system for restaurants, allowing users to:

1. Write reviews with ratings, titles, descriptions, and photos
2. View all restaurant reviews updated in real-time
3. See ratings auto-calculated based on all user reviews

## Key Components

### 1. ReviewModel (`lib/features/core/models/review_model.dart`)

Data class for storing review information with smart time-ago formatting.

### 2. WriteReviewScreen (`lib/features/restaurant_page_screen/write_review_screen.dart`)

**Features:**

- **Photo Selection**: Tap "ADD PHOTOS" button to select multiple photos from gallery
- **Rating System**: Interactive 5-star rating with feedback text
- **Review Form**: Title (optional) and detailed review text
- **Data Capture**: Collects review data with timestamp and passes back to previous screen

**Key Methods:**

- `_pickImagesFromGallery()`: Opens gallery with multi-image select capability
- `_removeImage(int index)`: Remove individual photos before posting
- `_postReview()`: Validates input and sends review data back

**Passed Data Structure:**

```dart
{
  'userName': 'Current User',        // TODO: Replace with auth user
  'userProfileImage': '',            // TODO: Add from auth profile
  'title': String,                   // Review title
  'review': String,                  // Review text
  'rating': double,                  // 0.5 to 5.0
  'images': List<File>,              // Selected photos
  'timestamp': DateTime,             // Review creation time
}
```

### 3. CustomResReviewsPage (`lib/features/restaurant_page_screen/widgets/custom_res_reviews_page.dart`)

**Features:**

- **Dynamic Rating Calculation**: Automatically calculates average rating from all reviews
- **Review Count Update**: Updates count based on new reviews
- **Review Display**: Shows all reviews in a scrollable list
- **Empty State**: Friendly message when no reviews exist
- **Real-time Updates**: New reviews appear immediately at the top of the list

**Key Methods:**

- `_updateRating()`: Recalculates average rating and review count
- `_addNewReview()`: Adds new review and triggers UI update
- `_getTimeAgo()`: Formats timestamp to readable "time ago" string

## Complete User Flow

1. **User navigates to Restaurant Review Tab**
   - Sees current rating and number of reviews
   - Views list of existing reviews

2. **User taps "Write a Review"**
   - Navigates to WriteReviewScreen with restaurant details
   - Can select rating, write title, write review, add photos
   - Taps "Post Review" to submit

3. **Review is Posted**
   - Review data is returned to CustomResReviewsPage
   - New review added to the top of the list
   - Rating is recalculated and updated
   - Review count incremented

4. **Updates are Visible**
   - Star rating updates in real-time
   - Review count changes
   - New review appears in the list with "now" timestamp
   - Other users can see the updated information

## Dependencies Required

Add to `pubspec.yaml`:

```yaml
image_picker: ^1.0.4
```

Run: `flutter pub get`

## Navigation Integration

The routing is already configured in `app_router.dart`:

```dart
GoRoute(
  path: RouteName.writeReviewPage,
  name: RouteName.writeReviewPage,
  builder: (context, state) => WriteReviewScreen(...)
),
```

The review data flows back through GoRouter's result mechanism:

- WriteReviewScreen: `Navigator.of(context).pop(reviewData)`
- CustomResReviewsPage: `final result = await GoRouter.of(context).pushNamed(...)`

## TODO Items for Production

1. **Authentication Integration**
   - Replace 'Current User' with actual user name from Firebase Auth
   - Add user profile image from authenticated user

2. **Backend Integration**
   - Send review data to Firestore/backend
   - Fetch initial reviews from database
   - Persist photos to storage (Firebase Storage, etc.)

3. **Image Display**
   - Currently photos are stored as File objects in memory
   - Implement persistent image storage and retrieval

4. **Optional Features**
   - Edit/delete reviews
   - Sort reviews (newest, highest rated, most helpful)
   - Filter reviews by rating
   - Add review comments/replies

## File Changes Summary

| File                           | Changes                                                             |
| ------------------------------ | ------------------------------------------------------------------- |
| `pubspec.yaml`                 | Added `image_picker: ^1.0.4`                                        |
| `write_review_screen.dart`     | Complete rewrite with photo picker, rating capture, and data return |
| `custom_res_reviews_page.dart` | Converted to StatefulWidget with review list management             |
| `review_model.dart`            | Created new model class (optional, for future use)                  |
