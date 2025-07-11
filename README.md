# Authentication & Organization Access Control System

## Overview

This is a modern Ruby on Rails application providing robust authentication, organization-based access control, age-based participation rules, and a clean, user-friendly UI. It is designed for business-driven organizational management, supporting role-based permissions, age-group participation spaces, content filtering, and parental consent workflows.

---

## Features

### 1. Authentication (Devise)
- Secure user registration and login
- Date of birth and parental consent required at registration
- Account management (edit profile, change password)
- Clean login/registration forms with proper spacing

### 2. Organization-Based Access Control
- **Organizations:** Create, edit, delete organizations with age restrictions
- **Memberships:** Invite users by email, assign roles (admin/member), manage members
- **Role-Based Permissions:** Only admins can manage organizations and members
- **Analytics Dashboard:** Member count, recent members, member growth chart, CSV export
- **Age Restrictions:** Set min/max age for organization participation

### 3. Age-Based Participation Rules
- **Age Verification:** Required at registration with validation
- **Parental Consent:** Required for users under 18 (checkbox validation)
- **Age-Group Spaces:** Users can join only groups for their age
- **Content Filtering:** Posts and groups can have min/max age limits

### 4. Groups & Content
- **Groups:** Create, join, leave, and manage age-restricted groups
- **Group Memberships:** Role management within groups (admin/member)
- **Posts:** Create, view, and filter posts by age within groups
- **Age-Appropriate Access:** Users only see content they're eligible for

### 5. Analytics & Reporting
- **Organization Analytics:** Member count, recent activity, growth charts
- **CSV Export:** Download member lists as CSV files
- **Member Growth Tracking:** Visual charts showing membership over time

### 6. UI/UX
- Modern, clean styling for navigation, tables, forms, and buttons
- Conditional flash messages (only show when present)
- Responsive and accessible design
- Navigation hidden on login/registration pages

---

## Setup Instructions

### Prerequisites
- Ruby 3.4+
- Rails 8+
- SQLite (default, or configure another DB)

### Installation
1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd authentication_system
   ```
2. **Install dependencies:**
   ```sh
   bundle install
   ```
3. **Set up the database:**
   ```sh
   rails db:setup
   ```
4. **Start the server:**
   ```sh
   bin/dev
   # or
   rails server
   ```
5. **Visit the app:**
   Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Usage Guide

### User Registration & Login
- Sign up with email, password, date of birth, and parental consent (if under 18)
- Log in to access organizations, groups, and content
- Clean, properly spaced login forms

### Organizations
- Create a new organization (become admin automatically)
- Set min/max age for participation
- Invite members by email, assign roles (admin/member)
- Manage members and view comprehensive analytics
- Export member lists as CSV

### Groups (Participation Spaces)
- View all groups you are eligible to join (filtered by age)
- Join or leave groups with one-click buttons
- Create new groups with age restrictions
- Manage group memberships and roles

### Posts (Content)
- Create posts within groups with age restrictions
- Set min/max age for post visibility
- View only posts appropriate for your age
- Age-appropriate content filtering

### Analytics & Reporting
- Access organization analytics dashboard
- View member count and recent activity
- See member growth charts
- Download member lists as CSV files

### Parental Consent
- Users under 18 must check a parental consent box at registration
- Validation prevents registration without consent for minors

---

## Architecture
- **Devise:** Authentication with custom fields (date_of_birth, parental_consent)
- **Pundit:** Authorization with role-based policies
- **Models:** Organization, Membership, Group, GroupMembership, Post
- **Modern CSS:** Clean, responsive UI with proper spacing
- **CSV Export:** Built-in CSV generation for reports

---

## Testing
- Run all tests with:
  ```sh
  rails test
  ```

---

## Extending the System
- Add more analytics (activity logs, advanced charts, PDF exports)
- Implement advanced parental consent (email approval workflow)
- Add notifications, messaging, or more content types
- Add user activity tracking and audit logs

---

## License
MIT or your chosen license.
