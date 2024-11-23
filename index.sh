#!/bin/bash

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Prompt the user for the project name if not provided as an argument
if [ -z "$1" ]; then
    read -p "Enter the name of the Flutter project: " PROJECT_NAME
else
    PROJECT_NAME=$1
fi

# Ensure the project name is not empty
if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty. Exiting..."
    exit 1
fi

echo "Creating Flutter project: $PROJECT_NAME..."
flutter create "$PROJECT_NAME" || { echo "Failed to create Flutter project."; exit 1; }

cd "$PROJECT_NAME" || { echo "Failed to navigate to project directory."; exit 1; }

# Define the directory structure
DIRECTORIES=(
    "lib/data/models"
    "lib/data/repositories"
    "lib/data/datasources"
    "lib/domain/entities"
    "lib/domain/repositories"
    "lib/domain/usecases"
    "lib/presentation/screens/home/bloc"
    "lib/presentation/widgets"
    "lib/presentation/blocs"
    "lib/core/constants"
    "lib/core/utils"
    "lib/core/theme"
    "lib/core/error"
)

# Create directories
echo "Creating directory structure..."
for DIR in "${DIRECTORIES[@]}"; do
    mkdir -p "$DIR" && echo "Created: $DIR"
done

# Define the initial files and their content
declare -A FILES=(
    ["lib/presentation/screens/home/home_screen.dart"]="// HomeScreen UI code goes here"
    ["lib/presentation/screens/home/bloc/home_bloc.dart"]="// HomeBloc implementation"
    ["lib/presentation/screens/home/bloc/home_event.dart"]="// HomeEvent definition"
    ["lib/presentation/screens/home/bloc/home_state.dart"]="// HomeState definition"
    ["lib/presentation/blocs/app_bloc.dart"]="// App-level BLoC implementation"
    ["lib/presentation/blocs/app_event.dart"]="// AppEvent definition"
    ["lib/presentation/blocs/app_state.dart"]="// AppState definition"
    ["lib/app.dart"]="// Main app widget"
    ["lib/core/constants/constants.dart"]="// Add constants here"
    ["lib/core/utils/utils.dart"]="// Add utility functions here"
    ["lib/core/theme/theme.dart"]="// Theme definitions"
    ["lib/core/error/error.dart"]="// Error handling code"
)

# Create initial files
echo "Creating initial files..."
for FILE in "${!FILES[@]}"; do
    echo "${FILES[$FILE]}" > "$FILE" && echo "Created: $FILE"
done

echo "Flutter project '$PROJECT_NAME' setup completed successfully!"
