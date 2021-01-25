
export async function getAllQuestions() {
    // console.log("Sending request to the endpoint.")
    const response = await fetch('/questions')
    return await response.json();
}
